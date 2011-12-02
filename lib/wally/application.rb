$:.unshift(File.join(File.dirname(__FILE__)))
require "sinatra"
require "haml"
require "rdiscount"
require "mongoid"
require "wally/feature"

configure do
  set :haml, { :ugly=>true }

end

if ENV["MONGOHQ_URL"]
  Mongoid.configure do |config|
    config.url = ENV["MONGOHQ_URL"] if ENV["MONGOHQ_URL"]
  end
else
  Mongoid.configure do |config|
    config.master = Mongo::Connection.new.db("wally")
  end
end

def lists_features
  Wally::ListsFeatures.new
end

def tag_count
  Wally::CountsTags.new(lists_features).count_tags
end

def excessive_wip_tags
  tag_count["@wip"] >= 10
end

def scenario_count
  lists_features.features.to_s.scan(/scenario/).length
end

def highlighted_search_result_blurb search_result
  offset = 0
  highlighted = search_result.object.text
  span_start = "<span class=\"search-result\">"
  span_end = "</span>"
  search_result.matches.each do |match|
    highlighted.insert(match.index + offset, span_start)
    offset += span_start.length
    highlighted.insert(match.index + match.text.length + offset, span_end)
    offset += span_end.length
  end
  highlighted
end

put '/features/?' do
  if File.exist?(".wally") && params[:authentication_code] == File.read(".wally").strip
    Wally::Feature.delete_all

    JSON.parse(request.body.read).each do |json|
      feature = Wally::Feature.new
      feature.path = json["path"]
      feature.content = json["content"]
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

get '/features/:feature/?' do |feature|
  lists_features.features.each do |feature_hash|
    @feature = feature_hash if feature_hash["id"] == feature
  end
  haml :feature
end

get '/progress/?' do
  haml :progress
end

get '/search/?' do
  if params[:q]
    @search_results = Wally::SearchFeatures.new(lists_features).find(:query => params[:q])
  end
  haml :search
end

get '/features/:feature/scenario/:scenario/?'  do  |feature_id, scenario_id|
  lists_features.features.each do |feature|
    if feature["id"] == feature_id
      @feature = feature
      feature["elements"].each do |element|
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

  if feature["elements"]
    feature["elements"].each do |element|
      if element["type"] == "scenario" || element["type"] == "scenario_outline"
        scenarios << element
      end
    end
  end
  scenarios.sort! { |a, b| a["name"] <=> b["name"] }
  scenarios
end
