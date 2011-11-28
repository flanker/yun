require 'yun/command'

module Yun
  class NodeCommand < Thor

    include Command

    desc "list", "list all nodes"
    def list
      yun.list
    end

    desc "create", "create a node"
    method_option :image, :aliases => "-i", :default => "ami-11d68a54", :desc => "Amazon Machine Image"
    method_option :instance_type, :aliases => "-t", :default => "t1.micro", :desc => "Instance Type"
    def create
      yun.create create_attributes
    end

    private
    def create_attributes
      {
        :image_id => options[:image],
        :flavor_id => options[:instance_type]
      }
    end

  end
end
