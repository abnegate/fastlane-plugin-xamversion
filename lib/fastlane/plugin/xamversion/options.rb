module Xamversion
  class Options
    def self.available_options
      [
        FastlaneCore::ConfigItem.new(key: :version,
                                     env_name: "FL_APP_VERSION",
                                     description: "App version value",
                                     optional: true),

        FastlaneCore::ConfigItem.new(key: :build,
                                     env_name: "FL_APP_BUILD",
                                     description: "App build number value",
                                     optional: true),

        FastlaneCore::ConfigItem.new(key: :readonly,
                                     env_name: "xamversion_READONLY",
                                     description: "Only print out current version and build",
                                     default_value: false,
                                     is_string: false,
                                     optional: true),

        FastlaneCore::ConfigItem.new(key: :bump,
                                     description: "Interactively bump version number",
                                     default_value: false,
                                     is_string: false,
                                     optional: true),

        FastlaneCore::ConfigItem.new(key: :platform,
                                     env_name: "xamversion_PLATFORM",
                                     description: "Targeted device platform (i.e. android, ios, osx)",
                                     optional: false),

        FastlaneCore::ConfigItem.new(key: :solution_path,
                                     env_name: "xamversion_SOLUTION_PATH",
                                     description: "Path to the build solution (sln) file",
                                     optional: true),

        FastlaneCore::ConfigItem.new(key: :project_path,
                                     env_name: "xamversion_PROJECT_PATH",
                                     description: "Path to the build project (csproj) file",
                                     optional: true),

        FastlaneCore::ConfigItem.new(key: :manifest_path,
                                     env_name: "xamversion_ANDROID_MANIFEST_PATH",
                                     description: "Path to the android manifest (xml) file",
                                     optional: true),

        FastlaneCore::ConfigItem.new(key: :plist_path,
                                     env_name: "xamversion_IOS_PLIST_PATH",
                                     description: "Path to the iOS plist file",
                                     optional: true)
      ]
    end
  end
end
