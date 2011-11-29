After do
  File.delete ".wally" if File.exist? ".wally"
end

Given /^I don't have a \.wally authorisation file$/ do
end

Given /^I have a \.wally authentication file$/ do
  @authentication_code = "authCodE!!2322"
  File.open(".wally", "w") do |file|
    file.write @authentication_code
  end
end

When /^I put data to \/features with the authentication code$/ do
  data = [{:path => "feature-name.feature", :content => "Feature: Feature Name"}].to_json
  page.driver.post "/features?authentication_code=#{@authentication_code}", data
end

Then /^I should get a (\d+) http status$/ do |status|
  page.driver.status_code.should eql status.to_i
end

Then /^I should see the uploaded feature$/ do
  page.body.should have_content "Feature Name"
end
