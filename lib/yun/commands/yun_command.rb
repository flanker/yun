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

    desc "test NODE_NAME, ROLE", "provision node with chef"
    def chef node_name, role
      ssh_config = SshConfig.new Config.key_name
      node = connection.find node_name
      ssh = Ssh.new node.ip, ssh_config

      ssh.chef role
    end

    register NodeCommand, :node, "node SUBCOMMAND", "commands for node"

    private
  end
end

Yun::YunCommand.start
