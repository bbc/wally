Then /^I should see a link to my sample features$/ do
  page.should have_link "Kate Moss", :href => "/project/features/kate-moss"
  page.should have_link "Katie Price", :href => "/project/features/katie-price"
  page.should have_link "Jessica-Jane Clement", :href => "/project/features/jessica-jane-clement"
  page.should have_link "Elle Macpherson", :href => "/project/features/elle-macpherson"
end

Then /^the features are ordered alphabetically$/ do
  page.body.should =~ /Elle Macpherson.*Jessica-Jane Clement.*Kate Moss.*Katie Price/m
end
