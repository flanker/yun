require 'thor'
require 'thor/group'
require 'yun/commands/command'
require 'yun/commands/node_command'

module Yun
  class CLI < Thor

    include Command

    desc "ssh NODE_NAME", "ssh to a node"
    def ssh node_name
      key = "~/.ssh/#{Config.key_name}.pem"
      user_name = "ec2-user"

      node = connection.find node_name
      server_ip = node.ip

      exec "ssh -i #{key} #{user_name}@#{server_ip}"
    end

    register NodeCommand, :node, "node SUBCOMMAND", "commands for node"
  end
end

Yun::CLI.start
