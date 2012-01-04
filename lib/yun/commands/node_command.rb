require 'hirb'

module Yun
  class NodeCommand < Thor

    include CommandBase

    desc "node list", "list all nodes"
    def list
      node_attributes = connection.list.map do |node|
        {
          :id => node.id,
          :name => node.name,
          :type => node.instance_type,
          :image => node.image,
          :ip => node.ip,
          :created_at => node.created_at.strftime("%Y-%m-%d %H:%M:%S"),
          :state => node.state
        }
      end
      puts Hirb::Helpers::AutoTable.render node_attributes
    end

    desc "node create NODE_NAME", "create a node"
    method_option :image, :aliases => "-i", :default => "ami-2e10406b", :desc => "Amazon Machine Image"
    method_option :instance_type, :aliases => "-t", :default => "t1.micro", :desc => "Instance Type"
    def create(node_name)
      $stdout.sync = true
      attributes = create_attributes node_name, options
      print "creating node."
      connection.create attributes do
        print "."
      end
      puts "\ndone"
    end

    desc "node destroy NODE_NAME", "destroy a node"
    def destroy node_name
      node = connection.find node_name
      node.destroy
    end

    private
    def create_attributes node_name, options
      {
        "name" => node_name,
        :image => options[:image],
        :instance_type => options[:instance_type],
        :key_name => Config.key_name
      }
    end

  end
end
