$:.unshift(File.join(File.dirname(__FILE__)))
require "sinatra"
require "haml"
require "rdiscount"
require "mongo_mapper"
require "wally/feature"
require "wally/project"
require "wally/search_features"
require "wally/counts_tags"
require "wally/parses_features"
require "cgi"

configure do
  set :haml, { :ugly=>true }
end

if ENV['MONGOHQ_URL']
  uri = URI.parse(ENV['MONGOHQ_URL'])
  MongoMapper.connection = Mongo::Connection.from_uri(ENV['MONGOHQ_URL'])
  MongoMapper.database = uri.path.gsub(/^\//, '')
else
  MongoMapper.connection = Mongo::Connection.new('localhost')
  MongoMapper.database = "wally"
end

def current_project
  @current_project ||= Wally::Project.first(:name => params[:project])
end

def tag_count
  return {} if current_project.nil?
  Wally::CountsTags.new(current_project).count_tags
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
  highlighted = search_result.object.text
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

put '/projects/:project/features/?' do
  if File.exist?(".wally") && params[:authentication_code] == File.read(".wally").strip
    current_project.delete if current_project
    project = Wally::Project.create(:name => params[:project])

    JSON.parse(request.body.read).each do |json|
      project.features << Wally::Feature.new(:path => json["path"], :gherkin => json["gherkin"])
    end
    project.save
    halt 201
  else
    error 403
  end
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

get '/projects/:project/?' do
  haml :project
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
