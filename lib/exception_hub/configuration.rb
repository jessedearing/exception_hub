module ExceptionHub
  module Configuration
    attr_accessor :repo_name, :user_name, :organization_name
    attr_reader :after_create_exception_callback, :before_create_exception_callback

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
      @after_create_exception_callback << block if block
    end

    def before_create_exception(&block)
      @before_create_exception_callback ||= []
      @before_create_exception_callback << block if block
    end
  end
end
