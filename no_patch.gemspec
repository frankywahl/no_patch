# coding: utf-8
# frozen_string_literal: true

lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require "no_patch/version"

Gem::Specification.new do |spec|
  spec.name          = "no_patch"
  spec.version       = NoPatch::VERSION
  spec.authors       = ["Franky W."]
  spec.email         = ["frankywahl@users.noreply.github.com"]
  spec.summary       = "Raise messages on monkey patching"
  spec.description   = "This tools allows for monkey patching of classes to be prevented"
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "yard"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "rubygems-tasks"
  spec.add_development_dependency "rubocop"
  spec.add_development_dependency "rubocop-rspec"
  spec.add_development_dependency "simplecov"
  spec.add_development_dependency "simplecov-console"
  spec.add_development_dependency "codeclimate-test-reporter"
end
