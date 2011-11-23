Given /^I am on the search page$/ do
  visit "/search"
end

When /^I search for "([^"]*)"$/ do |text|
  fill_in 'q', :with => text
  click_button 'Search'
end

Then /^I should see a search result link to "([^"]*)" with the url "([^"]*)"$/ do |text, url|
  within ".content" do
    page.should have_link text, :href => url
  end
end

Then /^I should see "([^"]*)" in the search results$/ do |text|
  within ".content" do
    page.should have_content text
  end
end
