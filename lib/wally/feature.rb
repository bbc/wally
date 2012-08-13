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
        f
      end
    end
    
    def id
      gherkin['id']
    end
    
    def gherkin=(gherkin)
      @gherkin = gherkin
      self.name = gherkin['name'] unless gherkin.nil?
    end
    
    def to_param
      id
    end
  end
end
