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
