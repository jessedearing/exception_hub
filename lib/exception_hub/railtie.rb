require 'exception_hub'
require 'rails'

module ExceptionHub
  class Railtie < Rails::Railtie
    railtie_name :exception_hub

    initializer "exception_hub rack middleware" do |app|
      app.config.middleware.insert 0, "ExceptionHub::Rack"
    end

    if defined?(::ActionDispatch::DebugExceptions)
      require 'exception_hub/rails/middleware/exceptions_interceptor'
      ::ActionDispatch::DebugExceptions.send(:include, ExceptionHub::Rails::Middleware::ExceptionsInterceptor)
    elsif defined(::ActionDispatch::ShowExceptions)
      require 'exception_hub/rails/controller_interceptor'
      ::ActionDispatch::ShowExceptions.send(:include, ExceptionHub::Rails::ControllerInterceptor)
    end

    rake_tasks do
      load 'tasks/exception_hub.rake'
    end
  end
end
