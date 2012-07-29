require 'digest/sha2'
# Persists exceptions in a JSON format
module ExceptionHub
  module Storage
    class Json
      def initialize(file = IO)
        self.IO = file
        self
      end

      def save(id, value)
        filename(id)
        self.IO.write(filename, JSON.dump(value))
        filename
      end

      def load(id)
        filename(id)
        f = self.IO.open(filename, "r") {|io| io.readlines.join}
        JSON.parse(f)
      end

      def find(query)
        Digest::SHA2.hexdigest(query)
      end

      protected
      attr_accessor :IO

      def filename(id=nil)
        @filename ||= Pathname(ExceptionHub.storage_path.join("#{id}.json"))
      end
    end
  end
end
