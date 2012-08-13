module Wally
  module UrlHelpers
    def project_feature_path(project, feature)
      "/projects/#{project.to_param}/features/#{feature.to_param}"
    end

    def project_topic_path(project, topic)
      "/projects/#{project.to_param}/topics/#{topic.to_param}"
    end
    
    def project_expanded_outline_path(project)
      "/projects/#{project.to_param}/expanded_outline"
    end

    def project_scenario_path(project, scenario)
      "/projects/#{project.to_param}/features/#{scenario["id"].gsub(";", "/scenario/")}"
    end

  end
end
