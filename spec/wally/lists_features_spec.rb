require File.join(File.dirname(__FILE__), "..", "spec_helper")
require 'fileutils'

module Wally
  describe ListsFeatures do
    before do
      FileUtils.mkdir_p "application-features"
    end

    after do
      FileUtils.rm_rf "application-features"
    end

    it "returns a list of alphabeticaly ordered features" do
      File.open("application-features/1-sample.feature", "w") do |file|
        file.write "Feature: Zorro"
      end
      File.open("application-features/2-sample.feature", "w") do |file|
        file.write "Feature: Malgor"
      end
      File.open("application-features/3-sample.feature", "w") do |file|
        file.write "Feature: Adrian"
      end
      lists_features = ListsFeatures.new("application-features")
      lists_features.features.size.should == 3
      lists_features.features[0]["name"].should == "Adrian"
      lists_features.features[1]["name"].should == "Malgor"
      lists_features.features[2]["name"].should == "Zorro"
    end
  end
end
