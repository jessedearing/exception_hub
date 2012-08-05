require 'digest/sha2'
# Persists exceptions in a JSON format
module ExceptionHub
  module Storage
    class Json
      def initialize(file = File, dir = Dir)
        self.File = file
        self.Dir = dir
        self
      end

      def save(id, value)
        create_dir
        filename(id)
        self.File.write(filename, JSON.dump(value))
        filename
      end

      def load(id)
        filename(id)
        create_dir
        return nil unless self.File.exists?(filename)
        f = self.File.open(filename, "r") {|io| io.readlines.join}
        JSON.parse(f)
      end

      def find(query)
        Digest::SHA2.hexdigest(query)
      end

      protected
      attr_accessor :File, :Dir

      def filename(id=nil)
        @filename ||= Pathname(ExceptionHub.storage_path.join("#{id}.json"))
      end

      def create_dir
        self.Dir.mkdir(ExceptionHub.storage_path) unless self.Dir.exists?(ExceptionHub.storage_path)
      end
    end
  end
end
