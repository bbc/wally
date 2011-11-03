Given /^a feature file named "([^"]*)" with the contents:$/ do |filename, contents|
  create_feature_file(filename, contents)
end

When /^I visit the sample feature page$/ do
  visit "/features/sample.feature"
end

Then /^I should see "([^"]*)"$/ do |text|
  page.should have_content(text)
end
