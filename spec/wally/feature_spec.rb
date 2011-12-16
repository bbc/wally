require File.join(File.dirname(__FILE__), "..", "spec_helper")

module Wally
  describe Feature do
    it "stores a feature path" do
      project = project("project")
      project.features << Feature.new(:path => "hello.feature")
      project.save
      Project.first.features.first.path.should == "hello.feature"
    end

    it "stores the feature content" do
      project = project("project")
      project.features << Feature.new(:gherkin => {"meh" => "ble"})
      project.save
      Project.first.features.first.gherkin.should == {"meh" => "ble"}
    end

    it "stores the feature name" do
      project = project("project")
      project.features << Feature.new(:gherkin => {"name" => "ble"})
      project.save
      Project.first.features.first.name.should == "ble"
    end
  end
end
