$:.unshift(File.join(File.dirname(__FILE__)))

require 'sinatra'
require 'haml'
require 'rdiscount'
require 'lists_features'
require 'search_features'

configure do
  set :haml, { :ugly=>true }
end

get '/features' do
  @features = ListsFeatures.features
  haml :features
end

get '/features/:feature' do |feature|
  features = ListsFeatures.features
  features.each do |feature_hash|
   @feature = feature_hash if feature_hash["id"] == feature
  end

  get_scenario_urls
  haml :feature
end

get '/search' do
  if params[:q]
    @features = SearchFeatures.new.find(:query => params[:q])
  end
  @q = params[:q]
  haml :search
end

get '/features/:feature/scenario/:scenario'  do  |feature_id, scenario_id|
  ListsFeatures.features.each do |feature|
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
