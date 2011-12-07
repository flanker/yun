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

  before :each do
    @connection = Yun::Connection.new options
  end

  it 'should create server with default value when no attributes given' do
    server = @connection.create

    server.flavor_id.should == 't1.micro'
  end

  it 'should create server using given attributes' do
    attributes =
      {
        :image => 'test_image_id',
        :instance_type => 'small_type',
        :key_name => 'some_key'
      }
    server = @connection.create attributes

    server.image_id.should == 'test_image_id'
    server.flavor_id.should == 'small_type'
    server.key_name.should == 'some_key'
  end

end
