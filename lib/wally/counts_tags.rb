module Wally
  class CountsTags
    def initialize project
      @project = project
    end

    def count_tags
      @project.features.inject(Hash.new(0)) do |tag_count, feature|
        if feature.gherkin["tags"]
          feature.gherkin["tags"].each do |tag|
            tag_count[tag["name"].downcase] += 1
          end
        end
        if feature.gherkin["elements"]
          feature.gherkin["elements"].each do |element|
            if element["tags"]
              element["tags"].each do |tag|
                tag_count[tag["name"].downcase] += 1
              end
            end
          end
        end
        tag_count
      end
    end
  end
end
