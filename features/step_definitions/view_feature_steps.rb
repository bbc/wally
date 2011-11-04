Given /^a feature file named "([^"]*)" with the contents:$/ do |filename, contents|
  @contents = contents
  create_feature_file(filename, @contents)
end

When /^I visit the sample feature page$/ do
  visit "/features/sample.feature"
end

Then /^I should see the feature file content$/ do
  @contents.lines.each do |line|
    page.should have_content(line.strip.chop)
  end
end

