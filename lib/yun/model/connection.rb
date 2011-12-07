require 'yun/model/fog_attributes'

module Yun
  class Connection
    def initialize options
      @servers = Fog::Compute.new(options).servers
    end

    def create attributes={}
      fog_attributes = FogAttributes.new attributes
      server = @servers.create fog_attributes
      Node.new server
    end

  end
end
