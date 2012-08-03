require 'zlib'
require 'archive/tar/minitar'

module Wally
  class ProjectPush
    class << self
      def tar_gz_push(project, tar_gz_io)
        project.clear_features
        Dir.mktmpdir(Wally::Config.work_dir) do |dir|
          FileUtils.cd(dir) do
            tgz = Zlib::GzipReader.new(tar_gz_io)
            Archive::Tar::Minitar.unpack(tgz, 'x')
            FileUtils.cd('x') do
              Dir['**/*{feature,md,markdown}'].each do |f|
                path = f.sub(/.*\/features\//, '')
                project.import_content(path, File.new(f))
              end
              if File.exists?('.nav')
                puts "found .nav file"
                project.customize(YAML::load(File.read('.nav')))
              end
            end
          end
        end
      end
    end
  end
end
  