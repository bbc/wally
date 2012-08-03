module Wally
  class Config
    class << self
      attr_accessor :work_dir
      attr_accessor :mongo_url, :mongo_database
      
      # Directory for use while processing feature pushes
      # and other file system dependent tasks.
      def work_dir
        @work_dir || File.join(File.dirname(__File__), '..', 'tmp')
      end

      def configure(settings = {})
        settings.each_pair do |k, v|
          send("#{k}=", v) if respond_to?("#{k}=")
        end
      end
    end
  end
end