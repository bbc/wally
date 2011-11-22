$:.unshift(File.join(File.dirname(__FILE__), "../../lib"))
ENV['RACK_ENV'] = 'test'
require "wally"
require "fileutils"
require "capybara/cucumber"
require "rspec"
require "fakefs/spec_helpers"

Capybara.app = Sinatra::Application

Before do
  ARGV.clear
  ARGV << "application-features"
  FileUtils.mkdir_p("application-features")
end

After do
  FileUtils.rm_rf("application-features")
end

def create_feature_file(file_name, contents)
  File.open(File.join("application-features", file_name), "w") do |file|
    file.write(contents)
  end
end
