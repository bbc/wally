$:.unshift(File.join(File.dirname(__FILE__), "../lib"))
ENV['RACK_ENV'] = 'test'
require "rack/test"
require "fakefs/spec_helpers"
require "fileutils"
require "wally"

before do
  ARGV.clear
  ARGV << "application-features"
end

RSpec.configure do |config|
  config.after :each do
    Wally::Project.delete_all
  end
end

def project name
  project = Wally::Project.first(:name => name)
  unless project
    project = Wally::Project.create(:name => name)
  end
  project
end

def create_feature project_name, path, content
  project = project(project_name)
  feature = Wally::Feature.new({
    :path => path,
    :gherkin => Wally::ParsesFeatures.new.parse(content)
  })
  project.features << feature
  project.save
end
