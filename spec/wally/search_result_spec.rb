require File.join(File.dirname(__FILE__), "..", "spec_helper")

module Wally
  describe SearchResult do
    subject { SearchResult.new(nil) }

    it "knows when there are no results" do
      subject.matches?.should == false
    end

    it "contains no matched scenarios" do
      subject.matched_scenarios.should == []
    end

    it "knows when there is a feature match" do
      subject.matched_feature = {}
      subject.matches?.should == true
    end

    it "knows when there are scenario matches" do
      subject.matched_scenarios = [{}]
      subject.matches?.should == true
    end
  end
end
