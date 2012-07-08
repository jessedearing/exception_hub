#!/usr/bin/env rake
require "bundler/gem_tasks"
require 'rspec/core/rake_task'
require 'yard'

desc "Run specs"
RSpec::Core::RakeTask.new
YARD::Rake::YardocTask.new

task :default => :spec
