Given /^I am on the search page$/ do
  visit "/search"
end

When /^I search for "([^"]*)"$/ do |text|
  fill_in 'q', :with => text
  click_button 'Search'
end

Then /^I should see a link to "([^"]*)" with the url "([^"]*)"$/ do |text, url|
  puts page.body
  page.should have_link text, :href => url
end
