require 'spec_helper'
require 'yun/version'

describe Yun do
  it 'should return the version' do
    Yun::VERSION.should == '0.0.3'
  end
end
