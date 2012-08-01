require 'wally/parses_features'

module Wally
  class Feature
    include MongoMapper::EmbeddedDocument

    key :path, String
    key :gherkin, Hash
    key :name, String

    class << self
      def parse_feature(path, io)
        f = new
        f.path = path
        f.gherkin = Wally::ParsesFeatures.parse(io.read)
        f.name = f.gherkin['name']
        f
      end
    end

    def id
      gherkin['id']
    end
    
    def to_param
      id
    end
  end
end
