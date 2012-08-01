When /^I follow "(.*?)" in the project sidebar$/ do |link|
  within(:css, '.sidebar') do
    click_link(link)
  end
end

Then /^I see a link to my sample features$/ do
  page.should have_link "Kate Moss", :href => "/projects/project/features/kate-moss"
  page.should have_link "Katie Price", :href => "/projects/project/features/katie-price"
  page.should have_link "Jessica-Jane Clement", :href => "/projects/project/features/jessica-jane-clement"
  page.should have_link "Elle Macpherson", :href => "/projects/project/features/elle-macpherson"
end

Then /^the features are ordered alphabetically$/ do
  page.body.should =~ /Elle Macpherson.*Jessica-Jane Clement.*Kate Moss.*Katie Price/m
end

Then /^I see the following listed in order in the project sidebar$/ do |table|
  link_texts = page.all(:css, '.sidebar ul.topics li a').map { |e| e.text.strip }
  link_texts.should == table.raw.flatten
end

