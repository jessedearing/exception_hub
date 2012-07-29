module ExceptionHub
  module Validator
    class FileSystem
      def create_issue?(exception, env)
        !exception_exists?(exception, env)
      end

      private
      def exception_exists?(exception, env)
        storage = ExceptionHub.storage
        stored = storage.load(storage.find(exception))
        if stored
          true
        else
          false
        end
      end
    end
  end
end
