$:.unshift(File.join(File.dirname(__FILE__)))
require "sinatra"
require "haml"
require "rdiscount"
require "mongo_mapper"
require "wally/feature"
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

def tag_count
  Wally::CountsTags.new(Wally::Feature).count_tags
end

def excessive_wip_tags
  tag_count["@wip"] >= 10
end

def scenario_count
  Feature.all.inject(0) do |count, feature|
    if feature.gherkin["elements"]
      count += feature.gherkin["elements"].select { |e| e["type"] == "scenario" }
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

put '/features/?' do
  if File.exist?(".wally") && params[:authentication_code] == File.read(".wally").strip
    Wally::Feature.delete_all

    JSON.parse(request.body.read).each do |json|
      feature = Wally::Feature.new
      feature.path = json["path"]
      feature.gherkin = json["gherkin"]
      feature.save
    end
    halt 201
  else
    error 403
  end
end

get '/?' do
  haml :index
end

get '/features/:feature/?' do |id|
  Wally::Feature.all.each do |feature|
    @feature = feature if feature.gherkin["id"] == id
  end
  haml :feature
end

get '/progress/?' do
  haml :progress
end

get '/search/?' do
  if params[:q]
    @search_results = Wally::SearchFeatures.new(Wally::Feature).find(:query => params[:q])
  end
  haml :search
end

get '/features/:feature/scenario/:scenario/?'  do  |feature_id, scenario_id|
  Wally::Feature.all.each do |feature|
    if feature.gherkin["id"] == feature_id
      @feature = feature
      feature.gherkin["elements"].each do |element|
        if element["type"] == "background"
          @background = element
        end
        if (element["type"] == "scenario" || element["type"] == "scenario_outline") && element["id"] == "#{feature_id};#{scenario_id}"
          @scenario = element
        end
      end
    end
  end
  haml :scenario
end

def get_scenario_url(scenario)
  url = "/features/#{scenario["id"].gsub(";", "/scenario/")}"
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
