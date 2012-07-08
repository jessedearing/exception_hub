module ExceptionHub
  module Configuration
    # @!attribute [rw]
    # @return [String] Name of the Github repository
    attr_accessor :repo_name

    # @!attribute [rw]
    # @return [String] Github username for the user account that hosts the repository
    attr_accessor :user_name
    alias_method :organization_name, :user_name
    alias_method :organization_name=, :user_name=

    # @!attribute [rw]
    # @return [Boolean] If true, sends all exceptions to Github including duplicates.
    attr_accessor :send_all_exceptions

    # @!attribute [rw]
    # @return [String] Github token to make API calls with
    attr_accessor :github_api_token

    # @!attribute [r]
    # @return [Array<Proc>] Callbacks after the exception is created
    attr_reader :after_create_exception_callbacks

    # @!attribute [r]
    # @return [Array<Proc>] Callbacks before the exception is created
    attr_reader :before_create_exception_callbacks

    # Provides configuration block for ExceptionHub
    #
    # @example
    #   ExceptionHub.configure do |config|
    #     config.repo_name = 'exception_hub'
    #     # ...
    #   end
    # @yield [config] Current instance of ExceptionHub::Configuration
    def configure
      yield(self) if block_given?
      true
    end
    alias_method :config, :configure

    def after_create_exception(&block)
      @after_create_exception_callbacks ||= []
      @after_create_exception_callbacks << block if block
    end

    def before_create_exception(&block)
      @before_create_exception_callbacks ||= []
      @before_create_exception_callbacks << block if block
    end
  end
end
