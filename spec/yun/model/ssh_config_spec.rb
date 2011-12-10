require 'spec_helper'

describe Yun::SshConfig do

  before do
    @key_name = 'some_key'
  end

  it 'should construct from config object' do
    ssh_config = Yun::SshConfig.new @key_name

    ssh_config.user.should == 'bitnami'
    ssh_config.key_file.should == '~/.ssh/some_key.pem'
  end

end
