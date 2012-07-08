require 'exception_hub'
require 'rails'

module ExceptionHub
  class Railtie < Rails::Railtie
    railtie_name :exception_hub

    rake_tasks do
      load 'tasks/exception_hub.rake'
    end
  end
end
