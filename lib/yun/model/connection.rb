require 'yun/model'

module Yun
  class Connection
    def initialize options
      @servers = Fog::Compute.new(options).servers
    end

    def create attributes={}, &block
      fog_attributes = FogAttributes.new attributes
      server = @servers.create fog_attributes
      server.wait_for do
        instance_eval(&block) if block_given?
        ready?
      end
      Node.new server
    end

    def list
      @servers.map do |server|
        Node.new server
      end
    end

    def find node_name
      node = list.find do |node|
        node.name == node_name and not node.is_destroyed?
      end
      if node == nil
        puts "Error: Cannot find node #{node_name}"
        exit 1
      end
      node
    end

  end
end
