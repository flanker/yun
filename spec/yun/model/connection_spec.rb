require 'spec_helper'

describe Yun::Connection do

  config = {
    :provider => 'aws',
    :aws_access_key_id => 'fake_aws_access_key_id',
    :aws_secret_access_key => 'fake_secret_access_key',
    :region => 'us-west-1'
  }

  before :all do
    Fog::Compute.new(config).key_pairs.create(:name => 'some_key')
  end

  after :each do
    Fog::Compute.new(config).servers.each do |server|
      server.destroy
    end
  end

  context 'create' do

    before :each do
      @connection = Yun::Connection.new config
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
      attributes = { "name" => 'test server' }

      node = @connection.create attributes

      node.name.should == 'test server'
    end

  end

  context 'list' do

    before :each do
      @connection = Yun::Connection.new config

      @one_node = @connection.create({ "name" => 'one node' })
      @other_node = @connection.create({ "name" => 'other node' })
    end

    it 'should return all the node' do
      nodes = @connection.list

      nodes.length.should == 2
      names = nodes.map { |node| node.name }
      names.sort.should == ['one node', 'other node']
    end

  end

  context 'find' do
    before do
      @connection = Yun::Connection.new config
      @one_node = @connection.create({ "name" => 'one node' })
    end

    it 'should find the node by node name' do
      node = @connection.find 'one node'

      node.name.should == 'one node'
    end
  end

end
