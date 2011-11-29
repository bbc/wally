require File.join(File.dirname(__FILE__), "..", "spec_helper")
require 'fileutils'

module Wally
  describe ListsFeatures do
    after do
      Feature.delete_all
    end

    def create_feature path, content
      feature = Feature.new
      feature.path = path
      feature.content = content
      feature.save
    end

    it "returns a list of alphabeticaly ordered features" do
      create_feature("1-sample.feature", "Feature: Zorro")
      create_feature("2-sample.feature", "Feature: Malgor")
      create_feature("3-sample.feature", "Feature: Adrian")
      lists_features = ListsFeatures.new("application-features")
      lists_features.features.size.should == 3
      lists_features.features[0]["name"].should == "Adrian"
      lists_features.features[1]["name"].should == "Malgor"
      lists_features.features[2]["name"].should == "Zorro"
    end
  end
end
