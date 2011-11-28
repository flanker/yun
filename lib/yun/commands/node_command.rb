require 'yun/command'

module Yun
  class NodeCommand < Command

    desc "list", "list all nodes"
    def list
      Yun.list
    end

  end
end
