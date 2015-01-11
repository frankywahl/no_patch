require "no_patch/version"

module NoPatch

  class RedifinitionError < StandardError; end

  def self.included(klass)

    def klass.method_added(sym)
      @immutable_instance_methods ||= []
      raise RedifinitionError if @immutable_instance_methods.include? sym
      @immutable_instance_methods << sym
      super
    end

    def klass.method_removed(sym)
      super
      raise RedifinitionError
    end

    def klass.method_undefined(sym)
      super
      raise RedifinitionError
    end

    # Heads up, this calls itself after being defined
    def klass.singleton_method_added(sym)
      @immutable_class_methods ||= []
      raise RedifinitionError if @immutable_class_methods.include? sym
      @immutable_class_methods << sym
      super
    end

    def klass.singleton_method_removed(sym)
      super
      raise RedifinitionError
    end

    def klass.singleton_method_undefined(sym)
      super
      raise RedifinitionError
    end

  end
end

# https://rawgit.com/booch/presentations/master/ruby_idioms/slides.html#34
module NoPatchFactory

  class RedifinitionError < StandardError; end

  def self.module(error_block: ->{})
    Module.new do
      module_eval %{
        def error_message
          puts "Entering"
          puts #{error_block}
          puts "Leaving"
        end
      }

      def self.included(klass)
        klass.instance_eval do
          def method_added(sym)
            @immutable_instance_methods ||= []
            send(:error_message) if @immutable_instance_methods.include? sym
            @immutable_instance_methods << sym
            super
          end

        end
      end

    end
  end
end


class Foo
  include NoPatchFactory.module(error_block: -> { raise "FOO" } )

  def brew
  end
end

class Foo
  #def brew
  #end
end

puts Foo.methods(false)
puts Foo.instance_methods(false)

