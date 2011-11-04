require 'gherkin/formatter/json_formatter'
require 'gherkin/parser/parser'


module Gherkin::Formatter
  class JSONFormatter
    def to_hash
      @feature_hash
    end
  end
end

class ListsFeatures
  class << self
    def features
      features = []
      Dir.glob("application-features/*.feature").each do |path|
        uri = "/features/#{path.gsub("application-features/", "")}"
        features << parse_gherkin(uri, File.read(path))
      end
      features
    end

    private

    def parse_gherkin(uri, text)
      io = StringIO.new
      formatter = Gherkin::Formatter::JSONFormatter.new(io)
      parser = Gherkin::Parser::Parser.new(formatter, false, 'root')
      parser.parse(text, uri, 0)
      hash = formatter.to_hash
      hash["contents"] = text
      hash
    end
  end
end
