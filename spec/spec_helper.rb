# frozen_string_literal: true

Dir["#{File.expand_path('../support', __FILE__)}/**/*.rb"].each { |f| require f }

require "pry"

$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "no_patch"

RSpec.configure do |c|
  c.color = true
  c.formatter = :documentation
end
