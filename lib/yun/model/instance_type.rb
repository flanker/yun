module Yun
  class InstanceType
    def self.parse readable_type
      case readable_type
        when "micro" then "t1.micro"
        when "small" then "m1.small"
      end
    end
  end
end
