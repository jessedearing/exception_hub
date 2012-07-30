module ExceptionHub
  class ExceptionStorage
    def perform(exception, env)
      storage = ExceptionHub.storage.new
      storage.save(storage.find(exception.filtered_message),
                                {:message => exception.message, :backtrace => exception.formatted_backtrace})
      self
    end
  end
end
