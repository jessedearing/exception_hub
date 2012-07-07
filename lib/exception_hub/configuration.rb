module ExceptionHub
  module Configuration
    attr_accessor :repo_name, :user_name, :organization_name, :after_create_exception_callback

    def user_org_name
      self.organization_name || self.user_name
    end

    def configure
      yield(self) if block_given?
      true
    end
    alias_method :config, :configure

    def after_create_exception(&block)
      @after_create_exception_callback ||= []
      @after_create_exception_callback << block
    end
  end
end
