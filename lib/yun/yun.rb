require 'fog'
require 'hirb'
require 'yun/config'

module Yun
  class Yun

    def self.list
      config = Config.new
      options = {:provider => "aws",
          :aws_access_key_id => config.aws_access_key_id,
          :aws_secret_access_key => config.aws_secret_access_key,
          :region => config.region}

      nodes = Fog::Compute.new(options).servers.map do |node|
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
