require 'spec_helper'
describe NoPatch do
  before(:each) do
    class Klass
      def foo; end
    end
  end

  after(:each)do
    Object.send(:remove_const, :Klass)
  end

  context "not including the module" do
    it "can redefine a method" do
      expect{
        class Klass
          def foo
            "foo"
          end
        end
      }.not_to raise_error
      expect(Klass.new.foo).to eql "foo"
    end

  end
  context "including the module" do
    before(:each) do
      class Klass
        include NoPatch
        def foo
          "initial"
        end
        def self.bar
          "end"
        end
      end
    end


    context "instance methods" do
      it "can be defined" do
        expect {
          class Klass
            def bar
            end
          end
        }.not_to raise_error
      end

      it "raises an error when being redefined" do
        expect {
          class Klass
            def foo
            end
          end
        }.to raise_error NoPatch::RedifinitionError
      end
    end

    context "class methods" do
      it "can be defined" do
        expect {
          class Klass
            def self.super
            end
          end
        }.not_to raise_error
      end

      it "raises an error when being redefined" do
        expect {
          class Klass
            def self.bar
            end
          end
        }.to raise_error NoPatch::RedifinitionError
      end
    end
  end
end
