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
    node = @connection.create

    node.instance_type.should == 't1.micro'
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

end
