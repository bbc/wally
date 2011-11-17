require File.join(File.dirname(__FILE__), "spec_helper")
require 'fileutils'
require 'lists_features'

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
    ListsFeatures.features.size.should == 3
    ListsFeatures.features[0]["name"].should == "Adrian"
    ListsFeatures.features[1]["name"].should == "Malgor"
    ListsFeatures.features[2]["name"].should == "Zorro"
  end

  it "returns the feature contents" do
    File.open("application-features/1-sample.feature", "w") do |file|
      file.write "Feature: 1 Sample Feature"
    end
    ListsFeatures.features.first["contents"].should == "Feature: 1 Sample Feature"
  end

end
