source("https://rubygems.org")

gem "csproj", path: "/Users/jakebarnby/Local/ruby-csproj"

gemspec

plugins_path = File.join(File.dirname(__FILE__), "fastlane", "Pluginfile")
eval_gemfile(plugins_path) if File.exist?(plugins_path)
