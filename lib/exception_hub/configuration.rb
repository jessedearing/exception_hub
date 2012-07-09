module ExceptionHub
  module Configuration
    IGNORED_EXCEPTIONS_DEFAULT = ['ActiveRecord::RecordNotFound',
                                  'ActionController::RoutingError',
                                  'ActionController::InvalidAuthenticityToken',
                                  'CGI::Session::CookieStore::TamperedWithCookie',
                                  'ActionController::UnknownAction',
                                  'AbstractController::ActionNotFound',
                                  'Mongoid::Errors::DocumentNotFound']
    # @!attribute [rw]
    # @return [String] Name of the Github repository
    attr_accessor :repo_name

    # @!attribute [rw]
    # @return [String] Github username for the user account that will make the API calls
    attr_accessor :github_user_name

    # @!attribute [rw]
    # @return [String] Name of the user or organization that hosts the repository
    attr_accessor :repo_owner

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

    # @!attribute [rw]
    # @return [Array<String>] Exception types as strings of the message to ignore
    attr_accessor :ignored_exceptions

    # @!attribute [rw]
    # @return [Array<Symbol] Environments to send exceptions from
    attr_accessor :reporting_environments

    # @!attribute [rw]
    # @return [Logger] Logger to send output messages to
    attr_accessor :logger

    # Provides configuration block for ExceptionHub
    #
    # @example
    #   ExceptionHub.configure do |config|
    #     config.repo_name = 'exception_hub'
    #     # ...
    #   end
    # @yield [config] Current instance of ExceptionHub::Configuration
    def configure
      define_defaults
      yield(self) if block_given?
      true
    end
    alias_method :config, :configure

    def define_defaults
      @after_create_exception_callbacks ||= []
      @before_create_exception_callbacks ||= []
      @ignored_exceptions ||= IGNORED_EXCEPTIONS_DEFAULT.dup
      @reporting_environments ||= [:production]
      @logger ||= (defined?(Rails) && Rails.logger) || Logger.new(STDOUT)
    end

    def after_create_exception(&block)
      @after_create_exception_callbacks << block if block
    end

    def before_create_exception(&block)
      @before_create_exception_callbacks << block if block
    end
  end
end
