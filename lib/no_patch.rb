# frozen_string_literal: true

require "no_patch/version"

# The no patch module provides a way to avoid a class from being monkey patched.
# An example of that would be shared code between two objects. You would not want
# any of the objects to define methods that are already defined in what is meant
# to be shared.
#
# This is evaluated at compile time so you can figure it out before your code
# makes it to production
#
# Example Usage:
#
#   class Foo
#     include NoPatch
#
#     def foo
#     end
#   end
#
# Now, further down the line:
#
#   class Foo
#     def foo
#     end
#   end # => raise NoPatch::RedifinitionError
#
#
# Warning: this does not prevent it from being redefined dynamically, aka
#
# Example:
#   a = Foo.new
#   def a.foo
#     puts "ok"
#   end
#
#   a.foo # => "ok"
#
module NoPatch
  # A specific error class
  #
  class RedifinitionError < StandardError; end

  # Used by including it in a class.
  # This is the hook that will be run each time a class includes it.
  #
  # Example
  #
  #   class Foo
  #     include NoPatch
  #   end
  #
  def self.included(klass)
    klass.extend(ClassMethods)
  end

  module ClassMethods
    def method_added(sym)
      @immutable_instance_methods ||= []
      raise RedifinitionError, "Method #{self}##{sym} cannot be redefined" if @immutable_instance_methods.include? sym
      @immutable_instance_methods << sym
      super
    end

    def method_removed(sym)
      super
      raise RedifinitionError, "Method #{self}##{sym} cannot be removed"
    end

    def method_undefined(sym)
      super
      raise RedifinitionError, "Method #{self}##{sym} cannot be undefined"
    end

    # Heads up, this calls itself after being defined
    def singleton_method_added(sym)
      @immutable_class_methods ||= []
      raise RedifinitionError, "Method #{self}::#{sym} cannot be redefined" if @immutable_class_methods.include? sym
      @immutable_class_methods << sym
      super
    end

    def singleton_method_removed(sym)
      super
      raise RedifinitionError, "Method #{self}::#{sym} cannot be removed"
    end

    def singleton_method_undefined(sym)
      super
      raise RedifinitionError, "Method #{self}::#{sym} cannot be undefined"
    end
  end
end
