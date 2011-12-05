require File.join(File.dirname(__FILE__), "..", "spec_helper")

module Wally
  describe Feature do
    after do
      Feature.delete_all
    end

    subject { Feature.new }

    it "stores a feature path" do
      subject.path = "hello.feature"
      subject.save
      Feature.all.first.path.should == "hello.feature"
    end

    it "stores the feature content" do
      subject.gherkin = {"meh" => "ble"}
      subject.save
      Feature.all.first.gherkin.should == {"meh" => "ble"}
    end

    it "stores the feature name" do
      subject.gherkin = {"name" => "ble"}
      subject.save
      Feature.all.first.name.should == "ble"
    end
  end
end
