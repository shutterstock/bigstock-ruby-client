# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'bigstock/client/version'

Gem::Specification.new do |spec|
  spec.name          = "bigstock-client"
  spec.version       = Bigstock::Client::VERSION
  spec.authors       = ["Moises Eskinazi"]
  spec.email         = ["meskinazi@shutterstock.com"]
  spec.summary       = %q{A ruby client for Bigstock's API}
  spec.description   = %q{A simple ruby library to access Bigstock's API. Bigstock is an easy-to-use marketplace for stock images}
  spec.homepage      = "http://rubygems.org/gems/bigstock-client"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
end