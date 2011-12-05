module Wally
  class Feature
    include MongoMapper::Document

    key :path, String
    key :content, String
  end
end
