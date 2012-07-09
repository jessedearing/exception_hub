require 'json'

module ExceptionHub
  class Notifier
    def initialize(exception, env)
      @exception = exception
      @env = env
    end

    def notify!
      begin
        issue = Issue.new
        issue.description = build_description
        issue.title = "#{@exception.class.name}: #{@exception.message}"

        issue.send_to_github
      rescue Exception => ex
        ExceptionHub.logger.error("ExceptionHub: #{ex.class.name}: #{ex.message}")
        ExceptionHub.logger.error(ex.backtrace.reduce("") {|memo, line| memo << line << "\n"})
      end
    end

    private
    def build_description
      backtrace = if @exception.backtrace
                    @exception.backtrace.reduce("") {|memo, line| memo << line << "\n"}
                  else
                    ""
                  end
      description = <<-DESC
## Exception Message
#{@exception.message}

## Data
### Backtrace
'''
#{backtrace}
'''

### Rack Env
'''
#{pretty_jsonify(@env)}
'''
      DESC
    end

    def pretty_jsonify(json)
      JSON.pretty_generate(JSON.parse(json.to_json))
    end
  end
end
