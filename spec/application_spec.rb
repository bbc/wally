require File.join(File.dirname(__FILE__), "spec_helper")
require 'application'

describe "Wally" do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  before do
    ListsFeatures.should_receive(:features).and_return([
      { "name" => "Sample Feature", "uri" => "/features/sample-feature.feature", "contents" => "feature contents" },
      { "name" => "Another Feature", "uri" => "/features/another-feature.feature" },
      { "name" => "Feature With Description", "uri" => "/features/feature-with-description.feature" , "description" => "The Feature Description"},
      { "name" => "Feature With Scenario", "uri" => "/features/feature-with-scenario.feature", "elements" => [{"keyword" => "Scenario", "name" => "The Scenario Name 1"}, { "keyword" => "Scenario", "name" => "The Scenario Name 2"}]},
      { "name" => "Feature With Scenario With Steps", "uri" => "/features/feature-with-scenario-with-steps.feature", "elements" => [
        {
          "name" => "Scenario Name",
          "keyword" => "Scenario",
          "steps" => [
                        { "keyword" => "Given", "name" => "I am doing stuff" },
                        { "keyword" => "When", "name" => "I continue doing stuff" },
                        { "keyword" => "Then", "name" => "I am active" }
                      ]
        }
      ]}
    ])
  end

  describe "GET /features" do
    it "should show a link to my sample feature" do
      get "/features"
      last_response.body.should include "Sample Feature"
    end
  end

  describe "GET /features/feature-name.feature" do
    it "should show the feature contents" do
      get "/features/sample-feature.feature"
      last_response.body.should include "feature contents"
    end
  end
end
