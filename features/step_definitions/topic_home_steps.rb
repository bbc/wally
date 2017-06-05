When /^I navigate into the "(.*?)" sub\-topic$/ do |link|
  within('section.topic ul.subtopics') do
    click_link(link)
  end
end

Then /^I see the topic page for "(.*?)"$/ do |topic|
  page.find(:css, 'section.topic h2').text.should include(topic)
end

Then /^I see the following sub\-topics listed in order$/ do |table|
  link_texts = page.all(:css, 'section.topic ul.subtopics li a').map { |e| e.text.strip }
  link_texts.should == table.raw.flatten
end
