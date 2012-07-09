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

    def pretty_jsonify(env)
      json = env_to_hash(env)
      JSON.pretty_generate(JSON.parse(json.to_json))
    end

    def env_to_hash(env)
      hash = {}
      env.keys do |key|
        if env[key].is_a?(Hash)
          hash[key] = env_to_hash(env[key])
        else
          hash[key] = env[key].to_s
        end
      end
      hash
    end
  end
end
