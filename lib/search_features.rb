require "lists_features"
require "search_result"

class SearchFeatures
  def find(query)
    results = []
    ListsFeatures.features.each do |feature|
      result = SearchResult.new(feature)

      if feature["tags"]
        feature["tags"].each do |tag|
          if tag["name"].downcase.include? query[:query].downcase
            result.matched_feature = feature
          end
        end
      end

      if feature["name"].downcase.include? query[:query].downcase
        result.matched_feature = feature
      end

      if feature["elements"]
        result.matched_scenarios = feature["elements"].select do |element|
          if element["name"].downcase.include? query[:query].downcase
            true
          elsif element["steps"]
            element["steps"].any? do |step|
              step["name"].downcase.include? query[:query].downcase
            end
          elsif element["tags"]
            element["tags"].any? do |tag|
              tag["name"].downcase.include? query[:query].downcase
            end
          end
        end
      end

      if result.matches?
        results << result
      end
    end
    results
  end
end
