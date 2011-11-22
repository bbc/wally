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
      Dir.glob("#{@feature_path}/*.feature").each do |path|
        features << parse_gherkin(File.read(path))
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
