require File.join(File.dirname(__FILE__), "..", "spec_helper")

module Wally
  describe ParsesFeatures do
    it "parses feature files" do
      feature = "Feature: Do stuff!"
      ParsesFeatures.new.parse(feature).should == {
        "keyword"     => "Feature",
        "name"        => "Do stuff!",
        "line"        => 1,
        "description" => "",
        "id"          => "do-stuff!",
        "uri"         => nil
      }
    end

    it "raises nice errors" do
      feature = "!WEFFW"
      error = nil
      begin
        ParsesFeatures.new.parse(feature)
      rescue Exception => e
        error = e
      end
      error.should_not be_nil
    end
  end
end
