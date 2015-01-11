require "no_patch/version"

module NoPatch

  class RedifinitionError < StandardError; end

  def self.included(klass)

    def klass.method_added(sym)
      raise RedifinitionError if self.immutable_instance_methods.include? sym
      @immutable_instance_methods << sym
      super
    end

    # Heads up, this calls itself after being defined
    def klass.singleton_method_added(sym)
      @immutable_class_methods ||= []
      raise RedifinitionError if @immutable_class_methods.include? sym
      @immutable_class_methods << sym
      super
    end

    private
    def klass.immutable_instance_methods
      @immutable_instance_methods ||= []
    end

    def klass.immutable_class_methods
      @immutable_class_methods ||= []
    end

  end


end
