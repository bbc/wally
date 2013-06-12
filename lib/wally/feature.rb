module Wally
  class Feature
    include MongoMapper::EmbeddedDocument

    key :path, String
    key :gherkin, Hash
    key :name, String

    before_save :save_feature_name

    def sorted_scenarios
      gherkin.fetch("elements",[]).inject([]) do |scenarios,element|
        if element["type"] == "scenario" || element["type"] == "scenario_outline"
          scenarios << element
        end
      end.sort! { |a, b| a["name"] <=> b["name"] }
    end

    private
      def save_feature_name
        @name = gherkin["name"]
      end
  end
end
