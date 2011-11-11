Then /^I should see Scenario headers as links$/ do
  page.body.should have_content "Scenarios:"
  page.should have_link "Sample Aidy", :href => "/features/sample-feature/scenario/sample-aidy"
  page.should have_link "Sample Andrew", :href => "/features/sample-feature/scenario/sample-andrew"
end
