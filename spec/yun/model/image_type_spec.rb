require "spec_helper"

describe Yun::ImageType do

  it "should parse human readable os type to ec2 image type" do
    Yun::ImageType.parse("amazon").should == "ami-1bd68a5e"
    Yun::ImageType.parse("ubuntu").should == "ami-2e10406b"
    Yun::ImageType.parse("windows").should == "ami-f53768b0"
  end
end
