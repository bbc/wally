$:.unshift(File.join(File.dirname(__FILE__), "../lib"))
ENV['RACK_ENV'] = 'test'
require 'rack/test'
