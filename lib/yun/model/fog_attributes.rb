module Yun
  class FogAttributes < Hash

    def initialize attributes
      attributes.each do |key, value|
        fog_key = get_fog_key key
        add fog_key, value
      end
    end

    private
    def add key, value
      self[key] = value
    end

    def get_fog_key key
      fog_key_mapping[key]
    end

    def fog_key_mapping
      {
        :image => :image_id,
        :instance_type => :flavor_id,
        :key_name => :key_name
      }
    end

  end
end
