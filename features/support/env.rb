$:.unshift(File.join(File.dirname(__FILE__), "../../lib"))
ENV['RACK_ENV'] = 'test'
require "wally"
require "fileutils"
require "capybara/cucumber"
require "rspec"
require "fakefs/spec_helpers"

Capybara.app = Sinatra::Application

After do
  Wally::Feature.delete_all
end

def create_feature path, content
  feature = Wally::Feature.new
  feature.path = path
  feature.content = content
  feature.save
end
