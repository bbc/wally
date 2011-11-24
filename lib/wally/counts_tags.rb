module Wally
  class CountsTags
    def initialize lists_features
      @lists_features = lists_features
    end

    def count_tags
      @lists_features.features.inject(Hash.new(0)) do |tag_count, feature|
        if feature["tags"]
          feature["tags"].each do |tag|
            tag_count[tag["name"]] += 1
          end
        end
        if feature["elements"]
          feature["elements"].each do |element|
            if element["tags"]
              element["tags"].each do |tag|
                tag_count[tag["name"]] += 1
              end
            end
          end
        end
        tag_count
      end
    end
  end
end
