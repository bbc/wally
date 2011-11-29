require File.join(File.dirname(__FILE__), "..", "spec_helper")

module Wally
  describe Feature do
    after do
      Feature.delete_all
    end

    it "stores a feature" do
      feature = Feature.new
      feature.content = "Feature: Bla"
      feature.save

      Feature.all.first.content.should == "Feature: Bla"
    end

    it "stores a feature path" do
      feature = Feature.new
      feature.path = "hello.feature"
      feature.save
      Feature.all.first.path.should == "hello.feature"
    end
  end
end
