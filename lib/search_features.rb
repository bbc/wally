require "lists_features"

class SearchFeatures
  def find(query)
    ListsFeatures.features.find_all do |feature|
      feature["contents"].downcase.include? query[:query].downcase
    end
  end
end
