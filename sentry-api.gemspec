# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sentry-api/version'

Gem::Specification.new do |spec|
  spec.name = "sentry-api"
  spec.version = SentryApi::VERSION
  spec.authors = ["Thierry Xing"]
  spec.email = ["thierry.xing@gmail.com"]
  spec.licenses = ['BSD']
  spec.summary = %q{Ruby client for Sentry API}
  spec.description = %q{A Ruby wrapper for the Sentry API}
  spec.homepage = "https://github.com/thierryxing/sentry-ruby-api"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "https://rubygems.org"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency 'httmultiparty', "~> 0.3.16"
  spec.add_development_dependency "bundler", "~> 1.12"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency 'rspec', "~> 3.5.0", '>= 3.5.0'
  spec.add_development_dependency 'webmock', "~> 2.1.0", '>= 2.1.0'
  spec.add_development_dependency 'yard', "~> 0.9.5"
end
