require 'simplecov'
require 'bundler/setup'
SimpleCov.start unless RUBY_ENGINE == 'rbx'
Bundler.require(:default, :test)
require 'exception_hub'


RSpec.configure do |config|
  TAGS = [:slow_test]

  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true
  TAGS.each do |tag|
    config.filter_run_excluding tag => true unless ENV["RUN_#{tag.to_s.upcase}"]
  end
end
