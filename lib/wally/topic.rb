module Wally
  class Topic
    include MongoMapper::EmbeddedDocument

    key :path, String
    key :id, String
    key :feature_id, String
    
    many :children, :class => Wally::Topic
     
    def topic(topic_path)
      if path == topic_path
        self
      else
        if topic_path.match(/^#{path}/)
          child = children.each do |t|
            break child if (child = t.topic(topic_path))
          end
        else
          nil
        end
      end  
    end
    
    def name
      File.basename(path)
    end
    alias_method :label, :name
    
    def feature?
      !feature_id.nil?
    end
    
    def child(path)
      children.detect { |c| c.path == path }
    end
    
    def ensure_descendents(descendent_path) 
      return self if path == fix_path(descendent_path)
      
      relative_path = descendent_path.sub("#{path}/", '')
      child_name = relative_path.split('/').first
      child_path = "#{path}/#{child_name}"
      unless (child = child(child_path)) 
        children << child = Topic.new(:path => child_path)
      end
      child.ensure_descendents(descendent_path)
    end
    
    def path=(p)
      @path = fix_path(p)
    end
    
    def link_feature(feature)
      @feature_id = feature.id
    end
    
    def to_param
      path.gsub('/', ':')
    end
    
    private
    
    def fix_path(p)
      p.to_s.sub(/\.feature$/, '')
    end
  end
end
