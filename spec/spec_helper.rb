require "codeclimate-test-reporter"
CodeClimate::TestReporter.start
require 'pry'
require 'no_patch'

RSpec.configure do |c|
  c.color = true
  c.formatter = :documentation
end
