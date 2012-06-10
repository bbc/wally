Given /^a feature file on the project "([^"]*)" with the contents:$/ do |project, contents|
  create_feature(project, "feature1.feature", contents)
end

Given /^I visit the project page for "([^"]*)"$/ do |project|
  visit "/projects/#{project}"
end

Given /^(\d+) projects exist$/ do |number_of_projects|
  number_of_projects.to_i.times do |project_number|
    project(project_number + 1)
  end
end

Then /^I see a link to the feature "([^"]*)"$/ do |feature|
  page.should have_link feature
end

Then /^I can switch to the (\d).+ project$/ do |project_number|
  select project_number, :from => 'projects'
  page.current_url.end_with?(project_number).should be_true
end
