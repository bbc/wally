module Wally
  class Feature
    include MongoMapper::Document

    key :path, String
    key :gherkin, Hash
  end
end
