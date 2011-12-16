module Wally
  class Project
    include MongoMapper::Document

    key :name, String
    many :features, :class => Wally::Feature
  end
end
