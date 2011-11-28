require 'yun/command'

module Yun
  class NodeCommand < Thor

    include Command

    desc "list", "list all nodes"
    def list
      yun.list
    end

  end
end
