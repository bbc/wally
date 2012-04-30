Then /^I see the feature free\-form narrative$/ do
  page.should have_content "In order to get some value"
  page.should have_content "As a person"
  page.should have_content "I want to create value"
end

Then /^I see Scenario headers as links$/ do
  page.body.should have_content "Scenarios"
  page.should have_link "Sample Aidy", :href => "/projects/project/features/sample-feature/scenario/sample-aidy"
  page.should have_link "Sample Andrew", :href => "/projects/project/features/sample-feature/scenario/sample-andrew"
end

Then /^the scenario links are sorted$/ do
  page.body.should =~ /C.*I.*N.*V/m
end
