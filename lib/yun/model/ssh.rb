require 'net/ssh'
require 'net/scp'

module Yun
  class Ssh

    attr_accessor :executor

    def initialize host, ssh_config
      @host = host
      @ssh_config = ssh_config
      executor = Yun::CommandExecutor.new
    end

    def connect
      ssh_command = "ssh -i #{key_file} #{user}@#{@host}"
      puts ssh_command
      executor.exec ssh_command
    end

    def chef role
      Net::SSH.start(@host, user, :keys => [key_file]) do |ssh|
        puts "packaging chef repo"
        tmp_chef_repo_tar = make_chef_repo_tar Config.chef_repo

        puts "uploading chef repo"
        ssh.scp.upload! tmp_chef_repo_tar, tmp_chef_repo_tar
        ssh.scp.upload! install_chef_file, "/tmp/install_chef_file.sh"
        ssh.scp.upload! chef_config_file, "/tmp/chef-solo.rb"

        puts "installing chef"
        remote_command ssh, "bash /tmp/install_chef_file.sh"

        remote_command ssh, "echo {\\\"run_list\\\":\\\"role[#{role}]\\\"} > /tmp/node.json"

        puts "executing chef"
        remote_command ssh, "sudo chef-solo -c /tmp/chef-solo.rb -j /tmp/node.json -r /tmp/chef-solo.tar.gz"

        puts "**********"
        puts "DONE"
      end
    end

    private
    def user
      @ssh_config.user
    end

    def key_file
      @ssh_config.key_file
    end

    def make_chef_repo_tar chef_repo
      tmp_tar = "/tmp/chef-solo.tar.gz"
      Dir.chdir(chef_repo) do
        system "tar -czvf #{tmp_tar} ./cookbooks ./roles"
      end
      tmp_tar
    end

    def install_chef_file
      File.expand_path(File.dirname(__FILE__) + '/../templates/install_chef.sh')
    end

    def chef_config_file
      File.expand_path(File.dirname(__FILE__) + '/../templates/chef-solo.rb')
    end

    def remote_command(ssh, command)
      ssh.open_channel do |channel|
        channel.exec(command) do |ch, success|
          raise "command failed: #{command}" unless success

          channel.on_data do |_ch, data|
            $stdout.print data
          end

          channel.on_extended_data do |_ch, _type, data|
            $stderr.print data
          end
        end
      end.wait
    end
  end
end
