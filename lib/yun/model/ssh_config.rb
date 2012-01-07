module Yun
  class SshConfig

    def initialize user, key_name
      @user = user
      @key_name = key_name
    end

    def user
      @user
    end

    def key_file
      "~/.ssh/#{@key_name}.pem"
    end

  end
end
