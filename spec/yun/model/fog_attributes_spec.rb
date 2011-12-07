require 'spec_helper'
require 'yun/model/fog_attributes'

describe Yun::FogAttributes do

  it 'should convert attributes to fog attributes hash' do
    attribute = { :image => 'test_image_id' }

    fog_attr = Yun::FogAttributes.new attribute

    fog_attr[:image_id].should == 'test_image_id'
  end

end
