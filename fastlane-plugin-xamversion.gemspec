lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "fastlane/plugin/xamversion/version"

Gem::Specification.new do |spec|
  spec.name = "fastlane-plugin-xamversion"
  spec.version = Fastlane::Xamversion::VERSION
  spec.author = "Jake Barnby"
  spec.email = "jakeb994@gmail.com"

  spec.summary = "Read and manipulate Android and iOS app versions."
  spec.homepage = "https://github.com/abnegate/fastlane-plugin-xamversion"
  spec.license = "MIT"

  spec.files = Dir["lib/**/*"] + %w[README.md LICENSE]
  spec.test_files = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "nokogiri", "~> 1.7"
  spec.add_dependency "mixlib-versioning", "~> 1.2"
  spec.add_dependency "csproj", "~> 0.1.0"

  spec.add_development_dependency("pry")
  spec.add_development_dependency("bundler")
  spec.add_development_dependency("rspec")
  spec.add_development_dependency("rspec_junit_formatter")
  spec.add_development_dependency("rake")
  spec.add_development_dependency("rubocop", "0.49.1")
  spec.add_development_dependency("rubocop-require_tools")
  spec.add_development_dependency("simplecov")
  spec.add_development_dependency("fastlane", ">= 2.169.0")
end
