require 'spec_helper'

describe Yun::FogAttributes do

  it 'should convert attributes to fog attributes hash' do
    attribute = { :image => 'test_image_id' }

    fog_attr = Yun::FogAttributes.new attribute

    fog_attr[:image_id].should == 'test_image_id'
  end

  it 'should save name attribute into tags' do
    attribute = { :name => 'test name' }

    fog_attr = Yun::FogAttributes.new attribute

    fog_attr[:tags][:name].should == 'test name'
  end

end
