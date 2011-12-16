module Wally
  class Feature
    include MongoMapper::EmbeddedDocument

    key :path, String
    key :gherkin, Hash
    key :name, String

    before_save :save_feature_name

    private
    def save_feature_name
      @name = gherkin["name"]
    end
  end
end
