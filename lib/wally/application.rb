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
  #probably remove this if not needed
  @features = lists_features.features
end

get '/?' do
  @features = lists_features.features
  haml :index
end

get '/features/:feature/?' do |feature|
  features = lists_features.features
  features.each do |feature_hash|
   @feature = feature_hash if feature_hash["id"] == feature
  end

  get_scenario_urls
  haml :feature
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

def get_scenario_urls
  @scenario_urls = {}
  return unless @feature
  if @feature["elements"]
    @feature["elements"].each do |element|
      if element["type"] == "scenario"
        url = "/features/#{element["id"].gsub(";", "/scenario/")}"
        @scenario_urls[element["name"]] = url
      end
    end
  end
end
