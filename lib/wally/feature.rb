module Wally
  class Feature
    include Mongoid::Document
    field :path, :type => String
    field :content, :type => String
  end
end
