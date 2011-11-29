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
    def initialize feature_path
      @feature_path = feature_path
    end

    def features
      features = []
      Feature.all.each do |feature|
        gherkinese = parse_gherkin(feature.content)
        gherkinese["path"] = feature.path
        features << gherkinese
      end
      features.sort {|a,b| a["name"] <=> b["name"]}
    end

    private

    def parse_gherkin(text)
      io = StringIO.new
      formatter = Gherkin::Formatter::JSONFormatter.new(io)
      parser = Gherkin::Parser::Parser.new(formatter, false, 'root')
      parser.parse(text, nil, 0)
      hash = formatter.to_hash
      hash
    end
  end
end
