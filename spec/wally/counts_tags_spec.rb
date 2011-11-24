require File.join(File.dirname(__FILE__), "..", "spec_helper")
require 'fileutils'
require "wally/counts_tags"

module Wally
  describe CountsTags do
    before do
      FileUtils.mkdir_p "application-features"
    end

    after do
      FileUtils.rm_rf "application-features"
    end

    def write_feature(name, contents)
      File.open("application-features/#{name}", "w") do |file|
        file.write(contents)
      end
    end

    it "counts feature tags" do
      write_feature("feature-1.feature", "@tag1 @tag2\nFeature: Feature 1")
      write_feature("feature-2.feature", "@tag2 @tag2\nFeature: Feature 2")
      lists_features = ListsFeatures.new("application-features")

      CountsTags.new(lists_features).count_tags.should == {
        "@tag1" => 1,
        "@tag2" => 3
      }
    end

    it "counts scenario tags" do
      write_feature("feature-1.feature", "Feature: Feature 1\n@tag1@tag1\nScenario: Scenario 1")
      write_feature("feature-2.feature", "Feature: Feature 2\n@tag3@tag1\nScenario: Scenario 1")
      lists_features = ListsFeatures.new("application-features")
      CountsTags.new(lists_features).count_tags.should == {
        "@tag1" => 3,
        "@tag3" => 1
      }
    end
  end
end
