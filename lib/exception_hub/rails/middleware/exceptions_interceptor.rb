module ExceptionHub
  module Rails
    module Middleware
      module ExceptionsInterceptor
        def self.included(base)
          base.send(:alias_method_chain, :render_exception, :exception_hub_intercept)
        end

        private
        def render_exception_with_exception_hub_intercept(env, exception)
          controller = env['action_controller.instance']
          ExceptionHub.handle_exception(exception, env)
          if defined?(controller.rescue_action_in_public_without_exception_hub)
            controller.rescue_action_in_public_without_exception_hub(exception)
          end
          render_exception_without_exception_hub_intercept(env, exception)
        end
      end
    end
  end
end
