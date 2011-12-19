When /^click on a scenario header link$/ do
  page.click_link "Sample Aidy"
end

Then /^a page appears with the scenario content$/ do
  page.body.should have_content "Sample Aidy"
  page.body.should have_content "Given my name is \"Aidy\""
  page.body.should have_content "When I drink alcohol"
  page.body.should have_content "Then I go nuts"
end

Then /^the background is visible$/ do
  page.body.should have_content "Background:"
  page.body.should have_content "Given some things"
end
