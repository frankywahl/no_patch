require 'spec_helper'
describe NoPatch do
  before(:each) do
    class Klass
      def foo; end
    end
  end

  after(:each) do
    Object.send(:remove_const, :Klass)
  end

  context 'not including the module' do
    it 'can redefine a method' do
      expect do
        class Klass
          def foo
            'foo'
          end
        end
      end.not_to raise_error
      expect(Klass.new.foo).to eql 'foo'
    end
  end
  context 'including the module' do
    before(:each) do
      class Klass
        include NoPatch
        def foo
          'initial'
        end

        def self.bar
          'end'
        end
      end
    end

    context 'instance methods' do
      it 'can be defined' do
        expect do
          class Klass
            def bar; end
          end
        end.not_to raise_error
      end

      it 'raises an error when being redefined' do
        expect do
          class Klass
            def foo; end
          end
        end.to raise_error NoPatch::RedifinitionError, 'Method Klass#foo cannot be redefined'
      end

      it 'raises an error when being removed' do
        expect do
          class Klass
            remove_method :foo
          end
        end.to raise_error NoPatch::RedifinitionError, 'Method Klass#foo cannot be removed'
      end

      it 'raises an error when being undefined' do
        expect do
          class Klass
            undef :foo
          end
        end.to raise_error NoPatch::RedifinitionError, 'Method Klass#foo cannot be undefined'
      end
    end

    context 'class methods' do
      it 'can be defined' do
        expect do
          class Klass
            def self.super; end
          end
        end.not_to raise_error
      end

      it 'raises an error when being redefined' do
        expect do
          class Klass
            def self.bar; end
          end
        end.to raise_error NoPatch::RedifinitionError, 'Method Klass::bar cannot be redefined'
      end

      it 'raises an error when being removed' do
        expect do
          class Klass
            class << self
              remove_method :bar
            end
          end
        end.to raise_error NoPatch::RedifinitionError, 'Method Klass::bar cannot be removed'
      end

      it 'raises an error when being undefined' do
        expect do
          class Klass
            class << self
              undef :bar
            end
          end
        end.to raise_error NoPatch::RedifinitionError, 'Method Klass::bar cannot be undefined'
      end
    end

    context 'inheriting from a class' do
      after(:each) do
        Object.send(:remove_const, :ChildKlass)
      end

      it 'instance methods can be redefined a child' do
        expect do
          class ChildKlass < Klass
            def foo
              puts 'ok'
            end
          end
        end.not_to raise_error
      end

      it 'class methods can be redefined a child' do
        expect do
          class ChildKlass < Klass
            def self.bar
              puts 'ok'
            end
          end
        end.not_to raise_error
      end
    end
  end
end
