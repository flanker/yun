require 'thor'

module Yun
  module Command

    def yun
      @yun ||= Yun.new options
    end

    def options
      {
        :provider => "aws",
        :aws_access_key_id => config.aws_access_key_id,
        :aws_secret_access_key => config.aws_secret_access_key,
        :region => config.region
      }
    end

    def config
      @config ||= Config.new
    end
  end
end
