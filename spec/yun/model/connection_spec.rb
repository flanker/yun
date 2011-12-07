require 'spec_helper'
require 'yun/model/connection'

describe Yun::Connection do

  options = {
    :provider => 'aws',
    :aws_access_key_id => 'fake_aws_access_key_id',
    :aws_secret_access_key => 'fake_secret_access_key',
    :region => 'us-west-1'
  }

  before do
    @connection = Yun::Connection.new options
  end

  it 'should create server with default value when no attributes given' do
    server = @connection.create

    server.flavor_id.should == 't1.micro'
  end

  it 'should create server using given image' do
    attributes = { :image => 'test_image_id' }
    server = @connection.create attributes

    server.image_id.should == 'test_image_id'

  end

end
