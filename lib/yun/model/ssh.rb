module Yun
  class Ssh

    def initialize host, ssh_config
      @host = host
      @ssh_config = ssh_config
    end

    def connect
      exec "ssh -i #{@ssh_config.key_file} #{@ssh_config.user}@#{@host}"
    end

  end
end
