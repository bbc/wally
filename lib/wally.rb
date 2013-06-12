require "rubygems"
require "bundler/setup"

$:.unshift(File.expand_path(File.dirname(__FILE__)))

require "cgi"
require "mongo_mapper"
require "wally/version"
require "wally/feature"
require "wally/project"
require "wally/search_features"
require "wally/counts_tags"
require "wally/parses_features"
require "wally/application"

module Wally
end
