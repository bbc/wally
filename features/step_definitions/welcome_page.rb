Given /^there aren't any projects$/ do
end

When /^I view the welcome page$/ do
  visit "/"
end

Then /^I see: "([^"]*)"$/ do |text|
  page.should have_content text
end

Then /^should not see "([^"]*)"$/ do |text|
  page.should_not have_content text
end

Then /^I see a link to the "([^"]*)" project$/ do |project_name|
  page.should have_link project_name, :href => "/#{project_name}"
end
