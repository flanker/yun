require 'thor'
require 'thor/group'
require 'yun/commands/command'
require 'yun/commands/node_command'

module Yun
  class CLI < Thor

    include Command

    desc "ssh NODE_NAME", "ssh to a node"
    def ssh node_name
      yun.ssh node_name
    end

    register NodeCommand, :node, "node SUBCOMMAND", "commands for node"
  end
end

Yun::CLI.start
