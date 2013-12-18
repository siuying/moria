# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'moria/version'

Gem::Specification.new do |spec|
  spec.name          = "moria"
  spec.version       = Moria::VERSION
  spec.authors       = ["Francis Chong"]
  spec.email         = ["francis@ignition.hk"]
  spec.description   = %q{Auto Layout DSL in RubyMotion.}
  spec.summary       = %q{Inspired by Masonry, Moria is a DSL for RubyMotion to create NSLayoutConstraint using Ruby style DSL.}
  spec.homepage      = "https://github.com/siuying/moria"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "motion-stump"
  spec.add_development_dependency "rake"
end
