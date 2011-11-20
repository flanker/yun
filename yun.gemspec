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
end
