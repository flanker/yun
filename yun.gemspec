$: << File.expand_path("../lib", __FILE__)
require "yun/version"

Gem::Specification.new do |gem|

  gem.name = "yun"
  gem.summary = "A command line tool to manage Amazon cloud service"
  gem.authors = ["Feng Zhichao"]
  gem.email =  ["flankerfc@gmail.com"]
  gem.homepage = "https://github.com/flanker/yun"

  gem.version = Yun::VERSION
  gem.platform = Gem::Platform::RUBY

  gem.require_path = "lib"
  gem.files        = `git ls-files`.split("\n")
  gem.executables  = "yun"

  gem.add_runtime_dependency "fog", ">= 1.0.0"
  gem.add_runtime_dependency 'hirb', '>= 0.4.5'
  gem.add_runtime_dependency 'thor', '>= 0.14.0'

  gem.add_development_dependency 'rspec', '~> 2.7'

  gem.post_install_message = <<-MSG
Thanks for installing yun!
You need put a config file in your home directory: ~/.yun
:default:
  :aws_access_key_id: YOUR_AWS_ACCESS_KEY_ID
  :aws_secret_access_key: YOUR_AWS_SECRET_ACCESS_KEY
  :region: us-west-1
  :key_name: YOUR_KEY_PAIR_NAME
  :chef_repo: /PATH/TO/YOUR/CHEF_REPO
MSG
end
