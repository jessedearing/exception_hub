module ExceptionHub
  module Validator
    class FileSystem
      def create_issue?(exception, env)
        !exception_exists?(exception, env)
      end

      private
      def exception_exists?(exception, env)
        storage = ExceptionHub.storage
        stored = storage.load(storage.find(exception.filtered_message))
        if stored
          #TODO More intelligent validation based on line number in callstack
          true
        else
          false
        end
      end
    end
  end
end
