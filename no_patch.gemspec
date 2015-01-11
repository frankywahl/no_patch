# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'no_patch/version'

Gem::Specification.new do |spec|
  spec.name          = "no_patch"
  spec.version       = NoPatch::VERSION
  spec.authors       = ["Franky W."]
  spec.email         = ["frankywahl@users.noreply.github.com"]
  spec.summary       = %q{Raise messages on monkey patching}
  spec.description   = %q{This tools allows for monkey patching of classes to be prevented}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'rdoc'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'rubygems-tasks', '~> 0.2'
end
