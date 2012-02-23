module Yun
  class ImageCommand < Thor

    include CommandBase

    desc "image list", "list all available images"
    def list
      images = Config.images
      result = images.keys.map do |key|
        {
          "image id" => images[key][:image],
          "os type" => key,
          "login user" => images[key][:user]
        }
      end
      puts Hirb::Helpers::AutoTable.render result
    end
  end
end
