require File.join(File.dirname(__FILE__), "..", "spec_helper")
require 'fileutils'

module Wally
  describe CountsTags do
    after do
      Feature.delete_all
    end

    def create_feature path, content
      feature = Feature.new
      feature.path = path
      feature.gherkin = ParsesFeatures.new.parse(content)
      feature.save
    end

    it "counts feature tags" do
      create_feature("feature-1.feature", "@tag1 @tag2\nFeature: Feature 1")
      create_feature("feature-2.feature", "@tag2 @tag2\nFeature: Feature 2")
      lists_features = ListsFeatures.new

      CountsTags.new(lists_features).count_tags.should == {
        "@tag1" => 1,
        "@tag2" => 3
      }
    end

    it "counts scenario tags" do
      create_feature("feature-1.feature", "Feature: Feature 1\n@tag1@tag1\nScenario: Scenario 1")
      create_feature("feature-2.feature", "Feature: Feature 2\n@tag3@tag1\nScenario: Scenario 1")
      lists_features = ListsFeatures.new
      CountsTags.new(lists_features).count_tags.should == {
        "@tag1" => 3,
        "@tag3" => 1
      }
    end

    it "counts feature tags irrespective of their case" do
      create_feature("feature-1.feature", "@tag1\nFeature: Feature 1")
      create_feature("feature-2.feature", "@TAG1\nFeature: Feature 2")
      create_feature("feature-3.feature", "Feature: Feature 2\n@TAG1\nScenario: Scenario 1")
      lists_features = ListsFeatures.new

      CountsTags.new(lists_features).count_tags.should == {
        "@tag1" => 3
      }
    end

  end
end
