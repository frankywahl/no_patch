require 'spec_helper'

describe NoPatchFactory do
  before(:each) do
    class Klass
      class MyError < StandardError; end
      include NoPatchFactory.module(error_block: ->{ raise MyError } )
    end
  end

  after(:each)do
    Object.send(:remove_const, :Klass)
  end

  it "can raise defined errors" do
    expect{
      class Klass
        def foo
        end
      end
    }.to raise_error Klass::MyError
  end
end
