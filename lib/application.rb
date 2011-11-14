$:.unshift(File.join(File.dirname(__FILE__)))
require 'sinatra'
require 'haml'
require 'lists_features'
require 'search_features'

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
  haml :search
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
