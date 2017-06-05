module Wally
  class ProjectCustomizer
    class << self
      def customize(project, config)
        new(project).customize_with(config)
      end
    end
        
    def initialize(project)
      @project = project
    end

    def customize_with(config)
      _customize_with(config, [])
    end

    private

    def _customize_with(config, parents)
      config.each_with_index do |item, index|
        sub_config = nil
        
        if item.is_a?(Hash)
          name = item.keys.first
          sub_config = item[name]
        else
          name = item
        end

        custom_name = nil
        if md = name.match(/(.*)\((.+)\)/)
          name = md[1].strip
          custom_name = md[2]
        end
        
        customize_topic(join_path(parents, name), index, custom_name)
        
        _customize_with(sub_config, parents + [name]) if sub_config
      end
    end

    def customize_topic(path, index, custom_name)
      if (topic = @project.topic(path))
        topic.sort_weight = index
        topic.name = custom_name if custom_name
      end
    end
    
    def join_path(parents, path)
      (parents + [path]).join('/').sub('.feature', '')
    end
  end
end
