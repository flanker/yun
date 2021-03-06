require 'spec_helper'
require 'fog/aws/models/compute/server'

describe Yun::Node do

  options = {
    :provider => 'aws',
    :aws_access_key_id => 'fake_aws_access_key_id',
    :aws_secret_access_key => 'fake_secret_access_key',
    :region => 'us-west-1'
  }

  after :each do
    Fog::Compute.new(options).servers.each do |server|
      server.destroy
    end
  end

  context 'basic attributes' do

    before do
      @time = Time.now
      attributes =
        {
          :id => 'id',
          :image_id => 'some_image',
          :flavor_id => 'small_type',
          :key_name => 'some_key',
          :state => 'running',
          :public_ip_address => '127.0.0.1',
          :created_at => @time
        }
      @ec2_node = Fog::Compute::AWS::Server.new attributes
    end

    it 'should convert all the ec2 node attribute' do
      node = Yun::Node.new @ec2_node

      node.id.should == 'id'
      node.image.should == 'some_image'
      node.instance_type.should == 'small_type'
      node.key_name.should == 'some_key'
      node.state.should == 'running'
      node.ip.should == '127.0.0.1'
      node.created_at == @time
    end

  end

  context 'node creation' do

    before do
      attributes = { :tags => { "name" => 'test node' } }
      @ec2_node = Fog::Compute::AWS::Server.new attributes
    end

    it 'should parse the name in the tags value' do
      node = Yun::Node.new @ec2_node

      node.name.should == 'test node'
    end

  end

  context 'node destroy' do

    before do
      @connection = Yun::Connection.new options
    end

    it 'should destroy ec2 node' do
      node = @connection.create

      node.destroy

      @connection.list.length.should == 0
    end

  end

end
