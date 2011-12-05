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
  class ParsesFeatures
    def parse text
      io = StringIO.new
      formatter = Gherkin::Formatter::JSONFormatter.new(io)
      parser = Gherkin::Parser::Parser.new(formatter, false, 'root')
      parser.parse(text, nil, 0)
      hash = formatter.to_hash
      hash
    end
  end
end
