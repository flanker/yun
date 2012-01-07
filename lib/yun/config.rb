require 'yaml'

module Yun
  class Config

    def self.aws_access_key_id
      setting[:aws_access_key_id]
    end

    def self.aws_secret_access_key
      setting[:aws_secret_access_key]
    end

    def self.region
      setting[:region]
    end

    def self.key_name
      setting[:key_name]
    end

    def self.chef_repo
      setting[:chef_repo]
    end

    def self.get_image os_name
      setting[:os][os_name.to_sym][:image]
    end

    def self.get_user os_name
      setting[:os][os_name.to_sym][:user]
    end

    private
    def self.setting
      @setting ||= YAML.load_file(config_file)[:default]
    end

    def self.config_file
      @config_file ||= File.expand_path('~/.yun')
    end

  end
end
