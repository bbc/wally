After do
  File.delete ".wally" if File.exist? ".wally"
end

Given /^I don't have a \.wally authorisation file$/ do
end

Given /^I have a \.wally authentication file$/ do
  @authentication_code = "authCodE!!2322"
  File.open(".wally", "w") do |file|
    file.write @authentication_code
  end
end

Then /^I get a (\d+) http status$/ do |status|
  page.driver.status_code.should eql status.to_i
end

Then /^I see the uploaded feature$/ do
  page.body.should have_content "Feature Name"
end

When /^I put data to \/my_project_name\/features with the authentication code$/ do
  gherkin = Wally::ParsesFeatures.new.parse("Feature: Feature Name")
  data = [{:path => "feature-name.feature", :gherkin => gherkin}].to_json
  page.driver.put "/projects/my_project_name/features?authentication_code=#{@authentication_code}", data
end

Given /^I create a project called "([^"]*)"$/ do |project_name|
  project project_name
  Wally::Project.first(:name => project_name).class.should equal Wally::Project
end

When /^I send DELETE to "([^"]*)"$/ do |project_path|
  page.driver.delete "#{project_path}?authentication_code=#{@authentication_code}"
end

Then /^"([^"]*)" should exist$/ do |project_name|
  Wally::Project.first(:name => project_name).class.should equal Wally::Project
end

Then /^"([^"]*)" should not exist$/ do |project_name|
  Wally::Project.first(:name => project_name).class.should_not equal Wally::Project
end

When /^I visit "([^"]*)" page$/ do |project_name|
  visit "/projects/#{project_name}"
end
