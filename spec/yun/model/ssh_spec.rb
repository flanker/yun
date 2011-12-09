require 'spec_helper'

describe Yun::Ssh do

  before do
    @ssh_config = Yun::SshConfig.new "test_key"
  end

  it 'should execute the correct ssh command' do
    ssh = Yun::Ssh.new "127.0.0.1", @ssh_config

    # ssh.connect
  end
end
