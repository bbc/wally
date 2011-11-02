require File.join(File.dirname(__FILE__), "spec_helper")
require 'application'

describe "Wally" do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  describe "GET /features" do
    it "should show a link to my sample feature" do
      ListsFeatures.should_receive(:features).and_return([
        { "name" => "Sample Feature", "uri" => "sample-feature.feature" }
      ])
      get "/features"
      last_response.body.should include "Sample Feature"
    end
  end
end
