require File.join(File.dirname(__FILE__), "spec_helper")
require 'application'

describe "Wally" do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  before do
    ListsFeatures.should_receive(:features).and_return([
      { "name" => "Sample Feature", "uri" => "/features/sample-feature.feature" },
      { "name" => "Another Feature", "uri" => "/features/another-feature.feature" },
      { "name" => "Feature With Description", "uri" => "/features/feature-with-description.feature" , "description" => "The Feature Description"}
    ])
  end

  describe "GET /features" do
    it "should show a link to my sample feature" do
      get "/features"
      last_response.body.should include "Sample Feature"
    end
  end

  describe "GET /features/feature-name.feature" do
    it "should show the feature name" do
      get "/features/another-feature.feature"
      last_response.body.should include "Another Feature"
    end

    it "should show the feature description" do
      get "/features/feature-with-description.feature"
      last_response.body.should include "The Feature Description"
    end
  end
end
