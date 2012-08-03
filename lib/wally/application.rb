$:.unshift(File.join(File.dirname(__FILE__)))
require 'sinatra'
require 'haml'
require 'rdiscount'
require 'mongo_mapper'
require 'wally/feature'
require 'wally/project'
require 'wally/search_features'
require 'wally/counts_tags'
require 'wally/projects_service'
require 'cgi'
require 'wally/url_helpers'
require 'wally/config'

configure do
  set :haml, { :ugly=>true }
end

config_file = File.expand_path(File.join(File.dirname(__FILE__), '..', '..', 'config', 'wally.yml'))
puts "using config file #{config_file}"
Wally::Config.configure(YAML.load(File.read(config_file)))

if ENV['MONGOHQ_URL']
  uri = URI.parse(ENV['MONGOHQ_URL'])
  MongoMapper.connection = Mongo::Connection.from_uri(ENV['MONGOHQ_URL'])
  MongoMapper.database = uri.path.gsub(/^\//, '')
else
  MongoMapper.connection = Mongo::Connection.new('localhost')
  MongoMapper.database = "wally"
end

include Wally::UrlHelpers

def current_project
  @current_project ||= Wally::Project.find_by_name(params[:project])
end

def tag_count
  return {} if current_project.nil?
  @tag_count ||= Wally::CountsTags.new(current_project).count_tags
end

def excessive_wip_tags
  tag_count["@wip"] >= 10 if tag_count["@wip"]
end

def scenario_count
  current_project.features.inject(0) do |count, feature|
    if feature.gherkin["elements"]
      count += feature.gherkin["elements"].select { |e| e["type"] == "scenario" }.size
    end
    count
  end
end

def highlighted_search_result_blurb search_result
  offset = 0
  highlighted = search_result.object.text.dup
  span_start = "!!SPAN_START!!"
  span_end = "!!SPAN_END!!"
  search_result.matches.each do |match|
    highlighted.insert(match.index + offset, span_start)
    offset += span_start.length
    highlighted.insert(match.index + match.text.length + offset, span_end)
    offset += span_end.length
  end
  highlighted = CGI::escapeHTML(highlighted)
  highlighted.gsub!(span_start, "<span class=\"search-result\">")
  highlighted.gsub!(span_end, "</span>")
  highlighted
end

def authenticated?
  File.exist?(".wally") && params[:authentication_code] == File.read(".wally").strip
end

def get_scenario_url(scenario)
  url = "/projects/#{current_project.name}/features/#{scenario["id"].gsub(";", "/scenario/")}"
end

def get_sorted_scenarios(feature)
  scenarios = []

  if feature.gherkin["elements"]
    feature.gherkin["elements"].each do |element|
      if element["type"] == "scenario" || element["type"] == "scenario_outline"
        scenarios << element
      end
    end
  end
  scenarios.sort! { |a, b| a["name"] <=> b["name"] }
  scenarios
end

post '/projects/:name' do |name|
  if Wally::Project.find_by_name(name)
    halt 409
  end
  Wally::Project.create(:name => name)
end

post '/projects/:name/pushes' do |name| 
  unless (project = Wally::Project.find_by_name(name))
    error 404
  end
  
  projects_service.tar_gz_push(project, request.body)
  project.save
  
  201
end

get '/projects/:project_id/topics/:topic_id' do |project_id, topic_id|
  @current_project = Wally::Project.find_by_name(project_id)
  @topic = @current_project.topic(topic_id)
  haml :topic
end

get '/?' do
  first_project = Wally::Project.first
  if first_project
    redirect "/projects/#{first_project.name}"
  else
    readme_path = File.expand_path(File.join(File.dirname(__FILE__), "../../README.md"))
    markdown File.read(readme_path), :layout => false
  end
end

get '/robots.txt' do
  "User-agent: *\nDisallow: /"
end

get '/projects/:project/?' do
  haml :project
end

delete '/projects/:project' do
  if (project = Wally::Project.find_by_name(params[:project]))
    project.destroy
  end
end

get '/projects/:project/features/:feature/?' do
  current_project.features.each do |feature|
    @feature = feature if feature.gherkin["id"] == params[:feature]
  end
  haml :feature
end

get '/projects/:project/progress/?' do
  haml :progress
end

get '/projects/:project/search/?' do
  if params[:q]
    @search_results = Wally::SearchFeatures.new(current_project).find(:query => params[:q])
  end
  haml :search
end

get '/projects/:project/features/:feature/scenario/:scenario/?' do
  current_project.features.each do |feature|
    if feature.gherkin["id"] == params[:feature]
      @feature = feature
      feature.gherkin["elements"].each do |element|
        if element["type"] == "background"
          @background = element
        end
        if (element["type"] == "scenario" || element["type"] == "scenario_outline") && element["id"] == "#{params[:feature]};#{params[:scenario]}"
          @scenario = element
        end
      end
    end
  end
  haml :scenario
end

def projects_service
  Wally::ProjectsService
end
