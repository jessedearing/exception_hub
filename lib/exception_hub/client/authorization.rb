require 'erb'

module ExceptionHub
  module Client
    module Authorization
      INITIALIZER_TEMPLATE = File.read(__FILE__).split("__END__\n").last

      def get_api_token(user, password, note = 'ExceptionHub', url = 'http://github.com/jessedearing/exception_hub')
        o = Octokit::Client.new(:login => user, :password => password)
        o.create_authorization(:scopes => [:repo], :note => note, :note_url => url)
      end

      def generate_initializer(user, api_token, auth_id)
        t = ERB.new(INITIALIZER_TEMPLATE)
        t.result binding
      end
    end
  end
end

__END__
ExceptionHub.configure do |config|
  # Github Authorization #<%= auth_id %>
  config.github_user_name = '<%= user %>'
  config.github_api_token = '<%= api_token %>'
end
