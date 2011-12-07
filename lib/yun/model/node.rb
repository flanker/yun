module Yun
  class Node

    def initialize server
      @server = server
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
      @server.tags[:name]
    end

    def state
      @server.state
    end

    def destroy
      @server.destroy
      @server.wait_for { not reload }
    end

  end
end