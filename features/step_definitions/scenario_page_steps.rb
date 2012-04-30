When /^click on a scenario header link$/ do
  find('.scenarios a').click
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

Then /^I should see the data table$/ do
  text_for_all('th').should == ['name', 'email']
  text_for_all('td').should == ['Aidy', 'aidy@example.com', 'Andrew', 'vos@example.com']
end

Then /^I should see the examples table$/ do
  text_for_all('th').should == ['start', 'eat', 'left']
  text_for_all('td').should == ['12', '5', '7', '20', '5', '15']
end

def text_for_all tag
  page.all(tag).collect { |heading| heading.text.strip }
end
