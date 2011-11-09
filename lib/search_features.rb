require "lists_features"

class SearchFeatures
  def find(query)
    ListsFeatures.features.find_all do |feature|
      feature["contents"].include? query[:query]
    end
  end
end
