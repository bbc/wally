$:.unshift(File.join(File.dirname(__FILE__), "../../lib"))
ENV['RACK_ENV'] = 'test'
require "fileutils"
require "application"
require "capybara/cucumber"
require "rspec"
require "fakefs/spec_helpers"


Capybara.app = Sinatra::Application

FEATURE_PATH = File.join(File.dirname(__FILE__), "../../application-features")

Before do
  FileUtils.mkdir_p(FEATURE_PATH)
end

After do
  FileUtils.rm_rf(FEATURE_PATH)
end

def create_feature_file(file_name, contents)
  File.open(File.join(FEATURE_PATH, file_name), "w") do |file|
    file.write(contents)
  end
end
