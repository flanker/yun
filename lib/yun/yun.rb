require 'fog'
require 'hirb'

module Yun
  class Yun

    def self.list
      nodes = Fog::Compute.new({:provider => "aws",
            :region => "us-west-1"}).servers.map do |node|
        {
          :id => node.id,
          :flavor_id => node.flavor_id,
          :image_id => node.image_id,
          :address => node.private_ip_address,
          :created_at => node.created_at,
          :status => node.state,
          :instance_type => node.root_device_type
        }
      end.sort_by do |node|
        node[:id] || ""
      end

      puts Hirb::Helpers::AutoTable.render nodes
    end
  end
end
