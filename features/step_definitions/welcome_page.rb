Given /^there aren't any projects$/ do
end

When /^I view the welcome page$/ do
  visit "/"
end

Then /^I should redirected to the "([^"]*)" project page$/ do |project|
  page.current_url.should include "/#{project}"
end

When /^I select the project "([^"]*)"$/ do |project|
  select(project, :from => "projects")
end

Then /^"([^"]*)" should be rendered$/ do |text|
  page.should have_content text
end

