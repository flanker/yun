require 'hirb'
require 'pp'

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
          :os => node.os,
          :ip => node.ip,
          :created_at => node.created_at.strftime("%Y-%m-%d %H:%M:%S"),
          :state => node.state
        }
      end
      puts Hirb::Helpers::AutoTable.render node_attributes
    end

    desc "node create NODE_NAME", "create a node"
    method_option :os, :aliases => "-o", :default => "ubuntu", :desc => "OS Name"
    method_option :instance_type, :aliases => "-t", :default => "micro", :desc => "Instance Type"
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
      $stdout.sync = true
      node = connection.find node_name
      print "destroy node."
      node.destroy { print "." }
      puts "\ndone"
    end

    desc "node info NODE_NAME", "show a node's info"
    def info node_name
      $stdout.sync = true
      node = connection.find node_name
      pp node.all_info
    end

    private
    def create_attributes node_name, options
      os = options[:os]
      {
        "name" => node_name,
        "os" => os,
        "user" => Config.get_user(os),
        :image => Config.get_image(os),
        :instance_type => InstanceType.parse(options[:instance_type]),
        :key_name => Config.key_name
      }
    end

  end
end
