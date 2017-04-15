# frozen_string_literal: true

task :irb do
  require "irb"
  require "no_patch"
  ARGV.clear
  IRB.start
end
