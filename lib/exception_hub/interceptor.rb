module ExceptionHub
  class Interceptor
    def initialize(exception, rack_env)
      @exception = exception
      @exception.extend FilteredException
      @env = rack_env
    end

    def intercept!
      if create_issue?
        ExceptionHub.handlers.map(&:new).each do |handler|
          ExceptionHub.before_create_exception_callbacks.each do |callback|
            callback.call(handler, @env)
          end

          handler.perform(@exception, @env)

          ExceptionHub.after_create_exception_callbacks.each do |callback|
            callback.call(handler, @env)
          end
        end
      end
      self
    end

    def create_issue?
      return false if ExceptionHub.ignored_exceptions.include? @exception.class.name
      return false unless included_rails_environment? || included_sinatra_environment? || included_rack_environment?

      true && ExceptionHub.validators.map do |validator|
        validator = validator.new if validator.is_a? Class
        validator.create_issue?(@exception, @env)
      end.reduce(true) {|memo, valid| memo &&= valid}
    end

    private
    def included_rails_environment?
      !!defined?(::Rails) && ExceptionHub.reporting_environments.include?(::Rails.env.to_sym)
    end

    def included_sinatra_environment?
      !!defined?(Sinatra::Base) && ExceptionHub.reporting_environments.include?(Sinatra::Base.environment)
    end

    def included_rack_environment?
      !!ENV['RACK_ENV'] && ExceptionHub.reporting_environments.include?(ENV['RACK_ENV'].to_sym)
    end
  end
end
