Given /^a feature file with the contents:$/ do |contents|
  create_feature_file("example-file.feature", contents)
end

When /^I visit the features page$/ do
  visit "/features"
end

Then /^I should see a link to my sample feature$/ do
  page.should have_link "Sample Feature", :href => "/features/sample-feature"
end
