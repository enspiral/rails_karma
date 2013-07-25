# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rails_karma/version'

Gem::Specification.new do |spec|
  spec.name          = "rails_karma"
  spec.version       = RailsKarma::VERSION
  spec.authors       = ["Joshua Vial"]
  spec.email         = ["joshua@enspiral.com"]
  spec.description   = %q{Integrate karma for javascript testing with rails}
  spec.summary       = %q{Integrate rkarma for javascript testing with rails}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
