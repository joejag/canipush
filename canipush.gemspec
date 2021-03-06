# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'canipush/version'

Gem::Specification.new do |spec|
  spec.name          = "canipush"
  spec.version       = Canipush::VERSION
  spec.authors       = ["Joe Wright"]
  spec.email         = ["joe@joejag.com"]
  spec.summary       = %q{Gem to check if you can push.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"

  spec.add_runtime_dependency 'colorize', '>= 0.7.3'
  spec.add_runtime_dependency 'nokogiri', '>= 1.5.11'
end
