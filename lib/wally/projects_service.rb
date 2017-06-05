require 'wally/project_push'

module Wally
  class ProjectsService
    class << self
      def tar_gz_push(project, io)
        Wally::ProjectPush.tar_gz_push(project, io)
      end
    end
  end
end