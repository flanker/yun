require 'yaml'

module Yun
  class Config

    def initialize
      @setting = YAML.load_file(config_file)[:default]
    end

    def config_file
      @config_file ||= File.expand_path('~/.yun')
    end

    def aws_access_key_id
      @setting[:aws_access_key_id]
    end

    def aws_secret_access_key
      @setting[:aws_secret_access_key]
    end

    def region
      @setting[:region]
    end

  end
end
