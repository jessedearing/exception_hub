module ExceptionHub
  module Rails
    module Middleware
      module ExceptionsInterceptor
        def self.included(base)
          base.send(:alias_method_chain, :render_exception, :exception_hub_intercept)
        end

        private
        def render_exception_with_exception_hub_intercept(env, exception)
          begin
            ExceptionHub.handle_exception(exception, env)
            render_exception_without_exception_hub_intercept(env, exception)
          rescue Exception => ex
            ExceptionHub.log_exception_hub_exception(ex)
          end
        end
      end
    end
  end
end
