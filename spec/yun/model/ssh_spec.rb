require 'spec_helper'

describe Yun::Ssh do

  before do
    ssh_config = Yun::SshConfig.new "user", "test_key"
    @ssh = Yun::Ssh.new "127.0.0.1", ssh_config
    @fake_executor = mock 'executor'
    @ssh.executor = @fake_executor
  end

  it 'should execute the correct ssh command' do
    expected_command = "ssh -i ~/.ssh/test_key.pem user@127.0.0.1"
    @fake_executor.expects(:sys_exec).with(expected_command).returns(true)

    @ssh.connect.should be_true
  end

end
