Given /^a feature file on the project "([^"]*)" with the contents:$/ do |project, contents|
  create_feature(project, "feature1.feature", contents)
end

Given /^I visit the project page for "([^"]*)"$/ do |project|
  visit "/#{project}"
end

Then /^I should see a link to the feature "([^"]*)"$/ do |feature|
  page.should have_link feature
end
