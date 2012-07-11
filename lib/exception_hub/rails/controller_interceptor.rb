module ExceptionHub
  module Rails
    module ContollerInterceptor
      def self.included(base)
        base.send(:alias_method, :rescue_action_in_public_without_exception_hub, :rescue_action_in_public)
        base.send(:alias_method, :rescue_action_in_public, :rescue_action_in_public_with_exception_hub)
      end

      private

      def rescue_action_in_public_with_exception_hub(exception)
        begin
          ExceptionHub.handle_exception(exception, {})
        rescue Exception => ex
          ExceptionHub.log_exception_hub_exception(ex)
        end
      end
    end
  end
end
