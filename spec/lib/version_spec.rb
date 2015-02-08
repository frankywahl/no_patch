require 'spec_helper'

describe NoPatch do
  it 'has a VERSION constant' do
    expect(subject.const_get('VERSION')).not_to be_empty
  end
end
