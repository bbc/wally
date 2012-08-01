require 'fileutils'

Given /^a directory "(.*?)" containing features$/ do |path|
  write_file(File.join(path, 'first.feature'), "Feature: First")
  write_file(File.join(path, 'second.feature'), "Feature: Second")
end

Given /^wally\-client is configured with the url of an accessible Wally server$/ do
  write_file('wally.yml', {'url' => 'http://localhost:4567'}.to_yaml)
end

When /^I attempt to add a project named "(.*?)" using wally\-client$/ do |name|
  run_simple(unescape("bundle exec wally-client add_project #{name}"), false)
end

When /^I attempt to push features to project "(.*?)" using wally\-client$/ do |name|
  write_file(File.join('features', 'first.feature'), "Feature: First")
  run_simple(unescape("bundle exec wally-client push #{name} features"), false)
end

