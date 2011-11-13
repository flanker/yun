require 'thor'

module Yun
  class Node < Thor

    desc "list", "list all nodes"
    def list
      Yun.list
    end

  end
end
