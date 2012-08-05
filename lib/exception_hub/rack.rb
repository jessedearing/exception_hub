module ExceptionHub
  # Rack middleware to intercept exceptions
  class Rack
    def initialize(app)
      @app = app
    end

    def handle_exception(exception, env)
      ExceptionHub.handle_exception(exception, env)
    end

    def call(env)
      begin
        response = @app.call(env)
      rescue Exception => ex
        env['exception_hub.issue_id'] = handle_exception(ex, env)
        raise
      end

      if env['rack.exception']
        env['exception_hub.issue_id'] = handle_exception(env['rack.exception'], env)
      end

      response
    end
  end
end
