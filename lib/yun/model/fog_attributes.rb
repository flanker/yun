module Yun
  class FogAttributes < Hash

    def initialize attributes
      convert_basic_attributes attributes
      convert_tags_attributes attributes
    end

    private
    def convert_basic_attributes attributes
      attributes.each do |key, value|
        convert key, value
      end
    end

    def convert key, value
      if fog_key_mapping.has_key? key
        fog_key = fog_key_mapping[key]
        self[fog_key] = value
      end
    end

    def fog_key_mapping
      {
        :image => :image_id,
        :instance_type => :flavor_id,
        :key_name => :key_name
      }
    end

    def convert_tags_attributes attributes
      tags_key = ["name"]
      tags_hash = attributes.reject do |key, value|
        not tags_key.include? key
      end
      self[:tags] = tags_hash
    end

  end
end
