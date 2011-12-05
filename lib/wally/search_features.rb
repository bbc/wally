require "komainu"

module Wally
  class SearchFeatures
    def initialize lists_features
      @lists_features = lists_features
    end

    def find(query)
      searchables = []

      @lists_features.all.each do |feature|
        feature_text = feature.gherkin["name"]
        if feature.gherkin["tags"]
          feature_text += " " + feature.gherkin["tags"].map { |tag| tag["name"] }.join(" ")
        end
        if feature.gherkin["description"]
          feature_text += " " + feature.gherkin["description"]
        end
        feature_data = OpenStruct.new
        feature_data.feature = feature.gherkin
        feature_data.text = feature_text
        searchables << feature_data

        if feature.gherkin["elements"]
          feature.gherkin["elements"].each do |element|
            element_text = [element["name"]]
            if element["steps"]
              element_text << element["steps"].map { |s| s["name"] }
            end
            if element["tags"]
              element_text << element["tags"].map { |t| t["name"] }
            end
            scenario_data = OpenStruct.new
            scenario_data.feature = feature.gherkin
            scenario_data.scenario = element
            scenario_data.text = element_text.join(" ")
            searchables << scenario_data
          end
        end
      end

      searches_text = Komainu::SearchesText.new(searchables)
      searches_text.search(query[:query])
    end
  end
end
