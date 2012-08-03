$:.unshift(File.join(File.dirname(__FILE__), "../../lib"))
ENV['RACK_ENV'] = 'test'
require "wally"
require "fileutils"
require "capybara/cucumber"
require "rspec"
require "fakefs/spec_helpers"
require 'aruba/cucumber'

Capybara.app = Sinatra::Application

Before do
  Wally::Project.delete_all
end

Capybara.register_driver :selenium_chrome do |app|
  Capybara::Selenium::Driver.new(app, :browser => :chrome)
end
Capybara.javascript_driver = :selenium_chrome

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
