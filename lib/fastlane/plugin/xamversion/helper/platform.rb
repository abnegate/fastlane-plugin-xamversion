module Xamversion
  module Platform
    IOS = "ios"
    OSX = "osx"
    ANDROID = "android"

    def self.from_lane_context(context)
      current_platform = context[:PLATFORM_NAME].to_s

      current_platform
    end
  end
end
