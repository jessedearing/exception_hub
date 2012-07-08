require 'exception_hub/version'
require 'exception_hub/configuration'
require 'exception_hub/issue'
require 'exception_hub/client'
require 'octokit'

# @author Jesse Dearing <jesse.dearing@gmail.com>
module ExceptionHub
  extend Configuration
  extend Client
end
