require 'spec_helper'
require 'yun/model/node'

describe Yun::Node do

  context 'basic attributes' do

    before do
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

  context 'node name' do

    before do
      options = { :tags => { :name => 'test node' } }
      @ec2_node = Fog::Compute::AWS::Server.new options
    end

    it 'should parse the name in the tags value' do
      node = Yun::Node.new @ec2_node

      node.name.should == 'test node'
    end

  end

end
