module Yun
  class SshConfig

    def initialize key_name
      @key_name = key_name
    end

    def user
      "bitnami"
    end

    def key_file
      "~/.ssh/#{@key_name}.pem"
    end
      
  end
end
