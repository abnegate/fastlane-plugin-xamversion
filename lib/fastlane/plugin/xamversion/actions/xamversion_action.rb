require "csproj"
require "csproj/platform"
require "mixlib/versioning"
require "fastlane/action"
require "fastlane/plugin/xamversion/helper/xamversion_helper"
require "fastlane/plugin/xamversion/options"

module Fastlane
  module Actions
    class XamversionAction < Action
      def self.run(values)
        values[:platform] = CsProj::Platform.from_lane_context(Actions.lane_context)

        CsProj.config = values.values

        current_version, current_build = set_version(
          values[:version],
          values[:build],
          values[:plist_path],
          values[:manifest_path]
        )

        if values[:bump] &&
            !values[:version] &&
            !values[:build] &&
            !values[:readonly]
          updated_version = do_version_bump_interactive(current_version)

          puts "Update version: #{updated_version}"
          new_version, new_build = set_version(
            updated_version || current_version,
            (current_build.to_i + 1).to_s,
            values[:plist_path],
            values[:manifest_path]
          )
        end

        UI.important "Current Version is:"
        UI.message "  Version: #{new_version || current_version} #{"(was #{current_version})" if !new_version.nil? && new_version != current_version}"
        UI.message "  Build: #{new_build || current_build} #{"(was #{current_build})" if !new_build.nil? && new_build != current_build}"

        {
          version: new_version,
          build: new_build
        }
      end

      def self.do_version_bump_interactive(current_version)
        bump_type = UI.select("Version bump type: ", ["Patch", "Minor", "Major"]).downcase
        type_name = case bump_type
                    when "patch"
                      "bugfixes"
                    when "minor"
                      "features"
                    when "major"
                      "non-backwards compatible changes"
        end

        semver_version = Mixlib::Versioning.parse(current_version)

        increment = UI.input("How many new #{type_name} were added since last release?")

        if /\A\d+\Z/.match?(increment)
          increment = increment.to_i
        else
          UI.user_error!("Not a valid integer!")
        end

        puts "Increment: #{increment}"

        current_count = semver_version.instance_variable_get("@#{bump_type}")
        puts "Current count: #{current_count}"

        semver_version.instance_variable_set("@#{bump_type}", current_count + increment)
        puts "Semver: #{semver_version.to_semver_string}"
        semver_version.to_semver_string
      end

      def self.set_version(version, build, plist_path = nil, manifest_path = nil)
        if CsProj.project.ios? || CsProj.project.osx?
          set_plist_version(version, build, plist_path)
        elsif CsProj.project.android?
          set_manifest_version(version, build, manifest_path)
        end
      end

      def self.set_plist_version(version, build, plist_path = nil)
        plist_path ||= CsProj.config[:plist_path]
        version ||= other_action.get_info_plist_value(path: plist_path, key: "CFBundleShortVersionString")
        build ||= other_action.get_info_plist_value(path: plist_path, key: "CFBundleVersion")

        other_action.set_info_plist_value(
          path: plist_path,
          key: "CFBundleShortVersionString",
          value: version
        )

        other_action.set_info_plist_value(
          path: plist_path,
          key: "CFBundleVersion",
          value: build
        )

        [version, build]
      end

      def self.set_manifest_version(version, build, manifest_path = nil)
        manifest_path ||= CsProj.config[:manifest_path]

        f1 = File.open(manifest_path)
        doc = Nokogiri::XML(f1)
        f1.close

        attrs = doc.xpath("//manifest")[0]

        version ||= attrs["android:versionName"]
        build ||= attrs["android:versionCode"]

        if version || build
          attrs["android:versionName"] = version if version
          attrs["android:versionCode"] = build if build

          File.open(manifest_path, "w") do |f2|
            f2.print(doc.to_xml)
          end
        end

        [version, build]
      end

      def self.description
        "Read and manipulate Android and iOS app versions."
      end

      def self.authors
        ["Jake Barnby"]
      end

      def self.return_value
        "Hash containing the latest version and build."
      end

      def self.details
        # Optional:
        "Allows you to read, set, increment and interactively bump Android and iOS app versions (following SemVer) and build numbers."
      end

      def self.available_options
        ::Xamversion::Options.available_options
      end

      def self.is_supported?(platform)
        true
      end
    end
  end
end
