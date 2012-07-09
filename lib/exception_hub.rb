require 'exception_hub/version'
require 'exception_hub/configuration'
require 'exception_hub/issue'
require 'exception_hub/client'
require 'exception_hub/rack'
require 'exception_hub/notifier'
require 'exception_hub/interceptor'
require 'octokit'

require 'exception_hub/railtie' if defined?(Rails)

# @author Jesse Dearing <jesse.dearing@gmail.com>
module ExceptionHub
  extend Configuration
  extend Client

  def self.handle_exception(exception, env)
    Interceptor.new(exception, env).intercept!
  end
end
