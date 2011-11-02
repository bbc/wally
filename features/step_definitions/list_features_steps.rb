$:.unshift(File.join(File.dirname(__FILE__), "../../lib"))
require "fileutils"
require "application"
require "capybara/cucumber"
require "rspec"

Capybara.app = Sinatra::Application

FEATURE_PATH = File.join(File.dirname(__FILE__), "../../application-features")

Before do
  FileUtils.mkdir_p(FEATURE_PATH)
end

After do
  FileUtils.rm_rf(FEATURE_PATH)
end

Given /^a feature file with the contents:$/ do |contents|
  File.open(File.join(FEATURE_PATH, "example-file.feature"), "w") do |file|
    file.write(contents)
  end
end

When /^I visit the features page$/ do
  visit "/features"
end

Then /^I should see a link to my sample feature$/ do
  page.should have_link "Sample Feature", :href => "/features/example-file.feature"
end
