# -*- encoding: utf-8 -*-
require File.expand_path('../lib/exception_hub/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Jesse Dearing"]
  gem.email         = ["jesse.dearing@gmail.com"]
  gem.description   = %q{exception_hub logs exceptions in your Rails application to Github issues}
  gem.summary       = %q{Logs exceptions in your application to Github issues}
  gem.homepage      = "https://github.com/jessedearing/exception_hub"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "exception_hub"
  gem.require_paths = ["lib"]
  gem.version       = ExceptionHub::VERSION

  gem.add_development_dependency('rspec', '~> 2.10.0')
end
