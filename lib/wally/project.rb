module Wally
  class Project
    include MongoMapper::Document

    key :name, String
    many :features, :class => Wally::Feature

    def scenario_count
      features.inject(0) do |count, feature|
        if feature.gherkin["elements"]
          count += feature.gherkin["elements"].select { |e| e["type"] == "scenario" }.size
        end
        count
      end
    end

    def tag_count
      @tag_count ||= Wally::CountsTags.new(self).count_tags
    end

    def excessive_wip_tags?
      tag_count["@wip"] >= 10 if tag_count["@wip"]
    end

  end
end
