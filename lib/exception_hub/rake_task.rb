require 'exception_hub'

module ExceptionHub
  class RakeTask < ::Rake::TaskLib
    include ::Rake::DSL if defined?(::Rake::DSL)

    def initialize(*args)
      namespace :exception_hub do
        desc "Generate ExceptionHub initializer"
        task :generate_initializer do
          puts "Github username:"
          username = STDIN.gets.chomp
          puts "Github password:"
          system('stty -echo')
          password = STDIN.gets.chomp
          system('stty echo')
          puts "Repo name:"
          repo_name = STDIN.gets.chomp
          puts "Repo owner:"
          repo_owner = STDIN.gets.chomp


          puts "Getting authorization from Github"
          auth = ExceptionHub.get_api_token(username, password)

          puts "Generating initializer"
          File.write('./config/initializers/exception_hub.rb', ExceptionHub.generate_initializer(username, auth.token, auth.id, repo_name, repo_owner))
        end
      end
    end
  end
end
