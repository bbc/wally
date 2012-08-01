module Wally
  module UrlHelpers
    def project_feature_path(project, feature)
      "/projects/#{project.to_param}/features/#{feature.to_param}"
    end

    def project_topic_path(project, topic)
      "/projects/#{project.to_param}/topics/#{topic.to_param}"
    end
  end
end
