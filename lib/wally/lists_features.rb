require 'gherkin/formatter/json_formatter'
require 'gherkin/parser/parser'

module Gherkin::Formatter
  class JSONFormatter
    def to_hash
      @feature_hash
    end
  end
end

module Wally
  class ListsFeatures
    def features
      features = []
      Feature.all.each do |feature|
        gherkin = feature.gherkin
        gherkin["path"] = feature.path
        features << gherkin
      end
      features.sort {|a,b| a["name"] <=> b["name"]}
    end
  end
end
