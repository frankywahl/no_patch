# frozen_string_literal: true

task :pry do
  require "pry"
  require "no_patch"
  ARGV.clear
  Pry.start
end
