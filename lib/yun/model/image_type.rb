module Yun
  class ImageType
    def self.parse os_type
      case os_type
        when "amazon" then "ami-1bd68a5e"
        when "ubuntu" then "ami-2e10406b"
        when "windows" then "ami-ed3768a8"
      end
    end
  end
end
