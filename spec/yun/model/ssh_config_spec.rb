require 'spec_helper'

describe Yun::SshConfig do

  before do
    @user = 'some_user'
    @key_name = 'some_key'
  end

  it 'should construct from config object' do
    ssh_config = Yun::SshConfig.new @user, @key_name

    ssh_config.user.should == @user
    ssh_config.key_file.should == '~/.ssh/some_key.pem'
  end

end
