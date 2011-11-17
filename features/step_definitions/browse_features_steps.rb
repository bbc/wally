Given /^a feature file with the contents:$/ do |contents|
  @current_file_number ||= 0
  @current_file_number += 1
  file_name = "feature_#{@current_file_number}.feature"
  create_feature_file(file_name, contents)
end

When /^I visit the features page$/ do
  visit "/features"
end

Then /^I should see a link to my sample features$/ do
    page.should have_link "Kate Moss", :href => "/features/kate-moss"
    page.should have_link "Katie Price", :href => "/features/katie-price"
    page.should have_link "Jessica-Jane Clement", :href => "/features/jessica-jane-clement"
    page.should have_link "Elle Macpherson", :href => "/features/elle-macpherson"
end

Given /^I am on the search page$/ do
  visit "/search"
end

When /^I search for "([^"]*)"$/ do |text|
  fill_in 'q', :with => text
  click_button 'Search'
end

Then /^I should see a link to "([^"]*)" with the url "([^"]*)"$/ do |text, url|
  page.should have_link text, :href => url
end

Given /^a feature file named "([^"]*)" with the contents:$/ do |filename, contents|
  @contents = contents
  create_feature_file(filename, @contents)
end

When /^I visit the sample feature page$/ do
  visit "/features/sample-feature"
end

Then /^I should see the feature free\-form narrative$/ do
  page.should have_content "In order to get some value"
  page.should have_content "As a person"
  page.should have_content "I want to create value"
end

Then /^I should see Scenario headers as links$/ do
  page.body.should have_content "Scenarios:"
  page.should have_link "Sample Aidy", :href => "/features/sample-feature/scenario/sample-aidy"
  page.should have_link "Sample Andrew", :href => "/features/sample-feature/scenario/sample-andrew"
end

When /^click on a scenario header link$/ do
  page.click_link "Sample Aidy"
end

Then /^a page appears with the scenario content$/ do
  page.body.should have_content "Scenario: Sample Aidy"
  page.body.should have_content "Given my name is \"Aidy\""
  page.body.should have_content "When I drink alcohol"
  page.body.should have_content "Then I go nuts"
end

Then /^the background is also visible$/ do
  page.body.should have_content "Background:"
  page.body.should have_content "Given some things"
end

Then /^the scenario links are sorted$/ do
  page.body.should =~ /C.*I.*N.*V/m
end


Then /^the features are ordered alphabetically$/ do
  page.body.should =~ /Elle Macpherson.*Jessica-Jane Clement.*Kate Moss.*Katie Price/m
end
