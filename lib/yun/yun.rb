require 'fog'
require 'hirb'
require 'yun/config'

module Yun
  class Yun

    def initialize options
      @servers = Fog::Compute.new(options).servers
    end

    def list
      nodes = @servers.map do |node|
        {
          :id => node.id,
          :node_name => node.tags['Name'],
          :flavor_id => node.flavor_id,
          :image_id => node.image_id,
          :address => node.public_ip_address,
          :created_at => node.created_at.strftime("%Y %b %d %H:%m:%S"),
          :status => node.state,
          :instance_type => node.root_device_type
        }
      end.sort_by do |node|
        node[:id] || ""
      end

      puts Hirb::Helpers::AutoTable.render nodes
    end

    def create attributes
      $stdout.sync = true

      server = @servers.create attributes

      print "creating node"

      server.wait_for { print "."; ready? }

      puts "\ndone"

      run_chef server
    end

    def destroy node_name
      server = find_by_node_name node_name
      if server == nil
        puts "cannot find server named #{node_name}"
      else
        server.destroy

        print "destroying node #{node_name}"

        server.wait_for { print "."; state == "terminated" }

        puts "\ndone"
      end
    end

    private
    def find_by_node_name node_name
      @servers.find do |server|
        server.tags['Name'] == node_name && server.state != "terminated"
      end
    end

    def run_chef server

    end
  end
end
