require 'spec_helper'
require 'yun/model/connection'

describe Yun::Connection do

  options = {
    :provider => 'aws',
    :aws_access_key_id => 'fake_aws_access_key_id',
    :aws_secret_access_key => 'fake_secret_access_key',
    :region => 'us-west-1'
  }

  before :all do
    Fog::Compute.new(options).key_pairs.create(:name => 'some_key')
  end

  after :each do
    Fog::Compute.new(options).servers.each do |server|
      server.destroy
    end
  end

  context 'create' do

    before :each do
      @connection = Yun::Connection.new options
    end

    it 'should create server with default value when no attributes given' do
      node = @connection.create

      node.instance_type.should == 't1.micro'
    end

    it 'should make sure the server is running in creation' do
      node = @connection.create

      node.state.should == 'running'
    end

    it 'should create server using given attributes' do
      attributes =
        {
          :image => 'test_image_id',
          :instance_type => 'small_type',
          :key_name => 'some_key'
        }
      node = @connection.create attributes

      node.image.should == 'test_image_id'
      node.instance_type.should == 'small_type'
      node.key_name.should == 'some_key'
    end

    it 'should create server with name' do
      attributes = { :name => 'test server' }

      node = @connection.create attributes

      node.name.should == 'test server'
    end

  end

  context 'list' do
    def create_ec2_node options
      server = Fog::Compute.new(options).servers.create
      server.wait_for { ready? }
    end

    before :all do
      @one_node = create_ec2_node options
      @otherone_node = create_ec2_node options
    end

    before :each do
      @connection = Yun::Connection.new options
    end

    it 'should return all the node' do
      nodes = @connection.list

      nodes.length.should == 2
      # TODO assert the node
      # nodes[0].name.should == 'one node'
      # nodes[1].name.should == 'other node'
    end

  end

end
