$:.unshift(File.join(File.dirname(__FILE__)))
require 'sinatra'
require 'haml'
require 'rdiscount'

configure do
  set :haml, { :ugly=>true }
end

def features_path
  ARGV.first || "features"
end

def lists_features
  Wally::ListsFeatures.new(features_path)
end

before do
  @features = lists_features.features
end

get '/?' do
  haml :index
end

get '/features/:feature/?' do |feature|
  @features.each do |feature_hash|
   @feature = feature_hash if feature_hash["id"] == feature
  end
  haml :feature
end

get '/search/?' do
  if params[:q]
    @search_results = Wally::SearchFeatures.new(lists_features).find(:query => params[:q])
  end
  haml :search
end

get '/features/:feature/scenario/:scenario/?'  do  |feature_id, scenario_id|
  @features.each do |feature|
    if feature["id"] == feature_id
      feature["elements"].each do |element|
        if element["type"] == "background"
          @background = element
        end
        if element["type"] == "scenario" && element["id"] == "#{feature_id};#{scenario_id}"
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
      if element["type"] == "scenario"
        scenarios << element
      end
    end
  end
  scenarios.sort! { |a, b| a["name"] <=> b["name"] }
  scenarios
end
