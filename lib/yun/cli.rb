require 'thor'
require 'thor/group'
require 'yun/commands/node_command'

module Yun
  class CLI < Thor

    register NodeCommand, :node, "node", "commands for node"
  end
end

Yun::CLI.start
