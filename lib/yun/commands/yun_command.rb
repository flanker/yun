module Yun
  class YunCommand < Thor

    include CommandBase

    desc "ssh NODE_NAME", "ssh to a node"
    def ssh node_name
      ssh_config = SshConfig.new Config.key_name
      node = connection.find node_name
      ssh = Ssh.new node.ip, ssh_config

      ssh.connect
    end

    register NodeCommand, :node, "node SUBCOMMAND", "commands for node"

    private
  end
end

Yun::YunCommand.start
