module Yun
  class Node

    def initialize server
      @server = server
    end

    def id
      @server.id
    end

    def image
      @server.image_id
    end

    def instance_type
      @server.flavor_id
    end

    def key_name
      @server.key_name
    end

    def name
      @server.tags["name"]
    end

    def os
      @server.tags["os"]
    end

    def user
      @server.tags["user"]
    end

    def state
      @server.state
    end

    def ip
      @server.public_ip_address
    end

    def created_at
      @server.created_at
    end

    def destroy &block
      @server.destroy
      @server.wait_for do
        instance_eval(&block) if block_given?
        not reload or state == 'terminated'
      end
    end

    def all_info
      @server
    end

    def is_destroyed?
      @server.state == 'terminated'
    end

    def wait_for_ssh_ready &block
      ssh_config = SshConfig.new user, key_name
      ssh = Ssh.new ip, ssh_config
      @server.wait_for do
        instance_eval(&block) if block_given?
        ssh.is_ssh_ready?
      end
    end

  end
end
