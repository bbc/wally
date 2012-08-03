module Wally
  class Topic
    include MongoMapper::EmbeddedDocument

    key :name, String
    key :path, String
    key :id, String
    key :feature_id, String
    key :sort_weight, Integer
    
    many :children, :class => Wally::Topic
     
    def topic(topic_path)
      if path == topic_path
        self
      else
        if topic_path.match(/^#{path}/)
          child = nil
          children.detect { |t| child = t.topic(topic_path) }
          child
        else
          nil
        end
      end  
    end
    
    def name
      @name || File.basename(path).humanize
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
    
    def add_child(topic)
      children << topic
    end
    
    def link_feature(feature)
      @feature_id = feature.id
      @name = feature.name
    end
    
    def to_param
      path.gsub('/', ':')
    end
    
    def feature(project)
      project.feature(feature_id)
    end
    
    def <=>(other)
      if sort_weight.nil?
        other.sort_weight.nil? ? (name <=> other.name) : 1
      else
        other.sort_weight.nil? ? -1 : (sort_weight <=> other.sort_weight)
      end
    end
    
    private
    
    def fix_path(p)
      p.to_s.sub(/\.feature$/, '')
    end
  end
end
