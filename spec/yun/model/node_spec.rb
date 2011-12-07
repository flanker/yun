require 'spec_helper'
require 'yun/model/node'

describe Yun::Node do

  before :all do
    options =
      {
        :image_id => 'some_image',
        :flavor_id => 'small_type',
        :key_name => 'some_key'
      }
    @ec2_node = Fog::Compute::AWS::Server.new options
  end

  it 'should convert all the ec2 node attribute' do
    node = Yun::Node.new @ec2_node

    node.image.should == 'some_image'
    node.instance_type.should == 'small_type'
    node.key_name.should == 'some_key'
  end
end
