require 'spec_helper'

describe Yun::InstanceType do

  it 'should parse the human readable name to ec2 instance type' do
    Yun::InstanceType.parse("micro").should == "t1.micro"
    Yun::InstanceType.parse("small").should == "m1.small"
  end
end

