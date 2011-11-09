require File.join(File.dirname(__FILE__), "spec_helper")
require "search_features"

describe SearchFeatures do
  include FakeFS::SpecHelpers

  it "finds features containing text" do
    FileUtils.mkdir "application-features"


    File.open("application-features/sample1.feature", "w") do |file|
      file.write("Feature: Bla")
    end

    File.open("application-features/sample1.feature", "w") do |file|
      file.write("Feature: Meh")
    end

    SearchFeatures.new.find(:query => "Meh").size.should == 1
    SearchFeatures.new.find(:query => "Meh").first["name"].should == "Meh"

  end
end
