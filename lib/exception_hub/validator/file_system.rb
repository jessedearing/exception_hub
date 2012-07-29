module ExceptionHub
  module Validator
    class FileSystem
      def create_issue?(exception, env)
        !exception_exists?(exception, env)
      end

      private
      def exception_exists?(exception, env)
        exception = exception.gsub(/ #\<(?:.*)\>/, '')
        storage = ExceptionHub.storage
        stored = storage.load(storage.find(exception))
        if stored
          #TODO More intelligent validation based on line number in call stacks
          true
        else
          false
        end
      end
    end
  end
end
