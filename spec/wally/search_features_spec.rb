require File.join(File.dirname(__FILE__), "..", "spec_helper")

module Wally
  describe SearchFeatures do
    before do
      FileUtils.mkdir "application-features"
    end

    after do
      FileUtils.rm_rf "application-features"
    end

    def write_feature(name, contents)
      File.open("application-features/#{name}", "w") do |file|
        file.write(contents)
      end
    end

    let :lists_features do
      ListsFeatures.new("application-features")
    end

    it "finds features containing text" do
      write_feature("sample1.feature", "Feature: Bla")
      write_feature("sample2.feature", "Feature: Meh")

      results = SearchFeatures.new(lists_features).find(:query => "Meh")
      results.items.size.should == 1
      results.items.first.feature["name"].should == "Meh"
    end

    it "finds features by narrative" do
      write_feature("sample1.feature", "Feature: bla\nIn order to bananas")
      results = SearchFeatures.new(lists_features).find(:query => "bananas")
      results.items.size.should == 1
      results.items.first.feature["name"].should == "bla"
    end

    it "has a suggestion" do
      write_feature("sample1.feature", "Feature: Monkeys")
      results = SearchFeatures.new(lists_features).find(:query => "mnkeys")
      results.suggestion.should == "Monkeys"
    end

    it "has a suggestion only when it's different from the search query" do
      write_feature("sample1.feature", "Feature: monkeys\nScenario: feature")
      write_feature("sample2.feature", "Feature: dogs\nScenario: Sample scenario")
      results = SearchFeatures.new(lists_features).find(:query => "feature")
      results.suggestion.should be_nil
    end

    context "feature with multiple scenarios" do
      before do
        contents = <<-CONTENTS
          Feature: Sample Feature
          Scenario: Sample Scenario
          Scenario: Matched Scenario
            Given I eat some doughnuts
          Scenario: Another Scenario
        CONTENTS
        write_feature("sample1.feature", contents)
      end

      it "finds scenarios containing text" do
        results = SearchFeatures.new(lists_features).find(:query => "MATCHED")
        results.items.size.should == 1
        results.items.first.scenario["name"].should == "Matched Scenario"
      end

      it "finds scenario steps" do
        results = SearchFeatures.new(lists_features).find(:query => "DOUGHNUTS")
        results.items.size.should == 1
        results.items.first.scenario["name"].should == "Matched Scenario"
      end
    end

    context "feature with tags" do
      it "finds features by tag" do
        write_feature("example-feature.feature", "@tag_name\nFeature: Example Feature")
        results = SearchFeatures.new(lists_features).find(:query => "@tag_NAME")
        results.items.first.feature["name"].should == "Example Feature"
      end

      it "finds scenarios by tag" do
        write_feature("example-feature.feature", "Feature: Example Feature\n@scenario_tag\nScenario: Example Scenario")
        results = SearchFeatures.new(lists_features).find(:query => "@scenario_TAG")
        results.items.first.scenario["name"].should == "Example Scenario"
      end
    end
  end
end
