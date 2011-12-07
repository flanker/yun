require 'yun/model/fog_attributes'

module Yun
  class Connection
    def initialize options
      @servers = Fog::Compute.new(options).servers
    end

    def create attributes={}
      fog_attributes = FogAttributes.new attributes
      @servers.create fog_attributes
    end

  end
end
