module ExceptionHub
  module FilteredException
    def filtered_message
      self.message.gsub(/ #\<.*\>/, '')
    end
  end
end
