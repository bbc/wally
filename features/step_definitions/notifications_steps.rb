Given /^a feature file with (\d+) @wip tags$/ do |wip_tag_count|
  contents = "Feature: Feature 1\n"
  1.upto(wip_tag_count.to_i) do |number|
    contents += "@wip\nScenario: Scenario #{number}\n"
  end
  create_feature("project", "sample1.feature", contents)
end

Then /^I see a notification that says "([^"]*)"$/ do |text|
  page.should have_content text
end
