require 'json'

module ExceptionHub
  class Notifier
    def perform(exception, env)
      @exception = exception
      @env = env
      self.notify!
      self
    end

    def notify!
      begin
        issue = Issue.new
        issue.description = build_description(@exception, @env)
        issue.title = "#{@exception.class.name}: #{@exception.message}"

        issue.send_to_github
      rescue Exception => ex
        ExceptionHub.log_exception_hub_exception(ex)
      end
    end

    private
    def build_description(exception, env)
      backtrace = if exception.backtrace
                    exception.backtrace.reduce("") {|memo, line| memo << line << "\n"}
                  else
                    ""
                  end
<<-DESC
## Exception Message
#{exception.message}

## Data
### Backtrace
```
#{backtrace}
```

### Rack Env
```
#{pretty_jsonify(env)}
```
      DESC
    end

    def pretty_jsonify(env)
      json = env_to_hash(env)
      JSON.pretty_generate(JSON.parse(json.to_json))
    end

    def env_to_hash(env)
      {}.tap do |hash|
        env.keys.each do |key|
          if env[key].is_a?(Hash)
            hash[key] = env_to_hash(env[key])
          else
            hash[key] = env[key].to_s
          end
        end
      end
    end
  end
end
