require 'thor'
require 'yun/model/connection'

module Yun
  module Command

    def connection
      @connection ||= Connection.new init_data
    end

    def init_data
      {
        :provider => "aws",
        :aws_access_key_id => Config.aws_access_key_id,
        :aws_secret_access_key => Config.aws_secret_access_key,
        :region => Config.region
      }
    end
  end
end
