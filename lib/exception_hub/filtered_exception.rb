module ExceptionHub
  module FilteredException
    def filtered_message
      self.message.gsub(/ #\<.*\>/, '')
    end

    def formatted_backtrace
      return "" unless backtrace
      backtrace.reduce("") {|memo, line| memo << line << "\n"}
    end
  end
end
