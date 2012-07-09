module ExceptionHub
  class Interceptor
    def initialize(exception, rack_env)
      @exception = exception
      @env = rack_env
    end

    def intercept!
      if should_create_issue?
        n = ExceptionHub::Notifier.new(@exception, @env)
        ExceptionHub.before_create_exception_callbacks.each do |callback|
          callback.call(n, @env)
        end

        n.notify!

        ExceptionHub.after_create_exception_callbacks.each do |callback|
          callback.call(n, @env)
        end
      end
      self
    end

    def should_create_issue?
      return false if ExceptionHub.ignored_exceptions.include? @exception.class.name

      return true if defined?(Rails) && ExceptionHub.reporting_environments.include?(Rails.env.to_sym)
      return true if defined?(Sinatra::Base) && ExceptionHub.reporting_environments.include?(Sinatra::Base.environment)
      return true if ENV['RACK_ENV'] && ExceptionHub.reporting_environments.include?(ENV['RACK_ENV'].to_sym)
      false
    end
  end
end
