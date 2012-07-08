require 'exception_hub/client/authorization'

module ExceptionHub
  module Client
    include Authorization

    # @returns [Octokit::Client] Returns an Octokit client singleton
    def current_octokit
      @current_octokit ||= get_octokit_client
    end

    # @returns [Octokit::Client] Creates new instance of the Octokit client singleton
    def reload_octokit!
      @current_octokit = get_octokit_client
    end

    protected
    def get_octokit_client
      if ExceptionHub.github_user_name && ExceptionHub.github_api_token
        Octokit::Client.new(:login => ExceptionHub.github_user_name, :oauth_token => ExceptionHub.github_api_token)
      else
        Octokit::Client.new
      end
    end
  end
end
