require File.join(File.dirname(__FILE__), "..", "spec_helper")
require 'fileutils'

module Wally
  describe Project do
    it "stores a name" do
      Project.create(:name => "project1")
      Project.first.name.should == "project1"
    end

    it "stores features" do
      Project.create({:name => "project2", :features => [
        Feature.new(:path => "feature/path")
      ]})
      Project.first.features.first.path.should == "feature/path"
    end
  end
end
