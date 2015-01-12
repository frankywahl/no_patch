require "no_patch/version"

module NoPatch

  class RedifinitionError < StandardError; end

  def self.included(klass)

    def klass.method_added(sym)
      @immutable_instance_methods ||= []
      raise RedifinitionError, "Method #{self}##{sym.to_s} cannot be redefined" if @immutable_instance_methods.include? sym
      @immutable_instance_methods << sym
      super
    end

    def klass.method_removed(sym)
      super
      raise RedifinitionError, "Method #{self}##{sym.to_s} cannot be removed"
    end

    def klass.method_undefined(sym)
      super
      raise RedifinitionError, "Method #{self}##{sym.to_s} cannot be undefined"
    end

    # Heads up, this calls itself after being defined
    def klass.singleton_method_added(sym)
      @immutable_class_methods ||= []
      raise RedifinitionError, "Method #{self}::#{sym.to_s} cannot be redefined" if @immutable_class_methods.include? sym

      @immutable_class_methods << sym
      super
    end

    def klass.singleton_method_removed(sym)
      super
      raise RedifinitionError, "Method #{self}::#{sym.to_s} cannot be removed"
    end

    def klass.singleton_method_undefined(sym)
      super
      raise RedifinitionError, "Method #{self}::#{sym.to_s} cannot be undefined"
    end

  end
end
