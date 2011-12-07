require 'rspec'
require 'fog'
require 'yun'

Fog.mock!

RSpec.configure do |config|
  config.color_enabled = true
  config.formatter     = 'documentation'
end
