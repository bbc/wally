$:.unshift(File.join(File.dirname(__FILE__), "../../lib"))
ENV['RACK_ENV'] = 'test'
require "wally"
require "fileutils"
require "capybara/cucumber"
require "rspec"
require "fakefs/spec_helpers"

Capybara.app = Sinatra::Application

After do
  Wally::Project.delete_all
end

require 'headless'
headless = Headless.new
at_exit do
  headless.destroy
end

Before("@selenium,@javascript", "~@no-headless") do
  headless.start if Capybara.current_driver == :selenium
end

After("@selenium,@javascript", "~@no-headless") do
  headless.stop if Capybara.current_driver == :selenium
end

def project name
  project = Wally::Project.first(:name => name)
  unless project
    project = Wally::Project.create(:name => name)
  end
  project
end

def create_feature project, path, content
  project = project(project)
  feature = Wally::Feature.new(:path => path, :gherkin => Wally::ParsesFeatures.new.parse(content))
  project.features << feature
  project.save
end
