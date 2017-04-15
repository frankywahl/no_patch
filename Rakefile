# frozen_string_literal: true

require "bundler/gem_tasks"
require "rspec/core/rake_task"

begin
  require "bundler"
rescue LoadError => e
  warn e.message
  warn "Run `gem install bundler` to install Bundler."
  exit(-1)
end

begin
  Bundler.setup(:development)
rescue Bundler::BundlerError => e
  warn e.message
  warn "Run `bundle install` to install missing gems."
  exit e.status_code
end

Rake.add_rakelib("tasks")

task test: :spec
task default: %i[spec rubocop]

task rebuild: %i[build install]
