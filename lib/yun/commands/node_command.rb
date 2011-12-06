require 'yun/command'
require 'yun/config'

module Yun
  class NodeCommand < Thor

    include Command

    desc "list", "list all nodes"
    def list
      yun.list
    end

    desc "create NODE_NAME", "create a node"
    method_option :image, :aliases => "-i", :default => "ami-11d68a54", :desc => "Amazon Machine Image"
    method_option :instance_type, :aliases => "-t", :default => "t1.micro", :desc => "Instance Type"
    def create(node_name)
      node_attributes = create_node_attributes node_name, options
      yun.create node_attributes
    end

    desc "destroy NODE_NAME", "destroy a node"
    def destroy node_name
      yun.destroy node_name
    end

    private
    def create_node_attributes node_name, options
      {
        :tags => create_node_tags(node_name, options),
        :image_id => options[:image],
        :flavor_id => options[:instance_type],
        :key_name => Config.key_name
      }
    end

    def create_node_tags node_name, options
      {
        "Name" => node_name
      }
    end

  end
end
