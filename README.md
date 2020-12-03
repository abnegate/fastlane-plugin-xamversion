# Xamversion Fastlane Plugin

[![fastlane Plugin Badge](https://rawcdn.githack.com/fastlane/fastlane/master/fastlane/assets/plugin-badge.svg)](https://rubygems.org/gems/fastlane-plugin-xamversion)
[![Gem Version](https://badge.fury.io/rb/fastlane-plugin-xamversion.svg)](https://badge.fury.io/rb/fastlane-plugin-xamversion)

## Getting Started

This project is a [_fastlane_](https://github.com/fastlane/fastlane) plugin. To get started with `fastlane-plugin-xamversion`, add it to your project by running:

```bash
fastlane add_plugin xamversion
```

## About xamversion

Fastlane plugin to easily read and manipulate Xamarin Android and iOS app version and build numbers.

## Example

Check out the [example `Fastfile`](fastlane/Fastfile) to see how to use this plugin. Try it by cloning the repo, running `fastlane install_plugins` and `bundle exec fastlane test`.

```ruby
platform :ios do
  desc "Just print the version and build"
  lane :example do
    xamversion
  end
  
  desc "Set version and/or build explicitly"
  lane :example do
    xamversion(
      version: "1.2.0",
      build:   20
    )
  end
  
  desc "Interactively update the version following SemVer"
  lane :example do
    xamversion(bump: true)
  end
  
  desc "If Info.plist or AndroidManifest.xml cannot be found"
  lane :example do
    xamversion(
      plist_path: "path/to/Info.plist",
      manifest_path: "path/to/AndroidManifest.xml"
    )
  end
end
```

## Issues and Feedback

For any other issues and feedback about this plugin, please submit it to this repository.

## Troubleshooting

If you have trouble using plugins, check out the [Plugins Troubleshooting](https://docs.fastlane.tools/plugins/plugins-troubleshooting/) guide.

## Using _fastlane_ Plugins

For more information about how the `fastlane` plugin system works, check out the [Plugins documentation](https://docs.fastlane.tools/plugins/create-plugin/).

## About _fastlane_

_fastlane_ is the easiest way to automate beta deployments and releases for your iOS and Android apps. To learn more, check out [fastlane.tools](https://fastlane.tools).
