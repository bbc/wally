require 'zlib'
require 'archive/tar/minitar'

module Wally
  class ProjectPush
    class << self
      def tar_gz_push(project, tar_gz_io)
        project.clear_features
        Dir.mktmpdir do |dir|
          FileUtils.cd(dir) do
            tgz = Zlib::GzipReader.new(tar_gz_io)
            Archive::Tar::Minitar.unpack(tgz, 'x')
            FileUtils.cd('x') do
              Dir['**/*'].each do |f|
                path = f.sub(/.*\/features\//, '')
                project.import_content(path, File.new(f))
              end
            end
          end
        end
        puts "topics: #{project.topics.inspect}"
      end
    end
  end
end
  