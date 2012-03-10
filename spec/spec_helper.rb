require 'rspec'
require 'fog'
require 'yun'
require 'mocha'

Fog.mock!

RSpec.configure do |config|
  config.color_enabled = true
end
