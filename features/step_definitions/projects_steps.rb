Given /^a feature file on the project "([^"]*)" with the contents:$/ do |project, contents|
  create_feature(project, "feature1.feature", contents)
end

Given /^I visit the project page for "([^"]*)"$/ do |project|
  visit "/projects/#{project}"
end

Given /^project "(.*?)" exists$/ do |name|
  p = Wally::Project.find_or_create_by_name(name)
  p.should_not be_nil
end

Given /^(\d+) projects exist$/ do |number_of_projects|
  number_of_projects.to_i.times do |project_number|
    project(project_number + 1)
  end
end

Given /^there is no project named "(.*?)"$/ do |name|
  if (p = Wally::Project.find_by_name(name))
    p.destroy
  end
end

Given /^I push the following features to project "(.*?)"$/ do |project, table|
  p =  Wally::Project.find_by_name!(project)
  table.hashes.each do |h|
    p.import_content(h['Path'], StringIO.new("Feature: #{h['Name']}"))
  end
  p.save
end

Then /^there should be an empty project named "(.*?)"$/ do |name|
  p = Wally::Project.find_by_name(name)
  p.should_not be_nil
  p.features.should be_empty
end

Then /^there should be features in project "(.*?)"$/ do |name|
  p = Wally::Project.find_by_name(name)
  p.should_not be_nil
  p.features.should_not be_empty
end

Then /^I see a link to the feature "([^"]*)"$/ do |feature|
  page.should have_link feature
end

Then /^I can switch to the (\d).+ project$/ do |project_number|
  select project_number, :from => 'projects'

  #This is needed because there seems to be a bug in the chrome driver.
  #The first time this is called, we get the old url, and the second time we get the new url.
  page.current_url

  page.current_url.end_with?(project_number).should be_true
end

