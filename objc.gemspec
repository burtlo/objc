# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'objc/version'

Gem::Specification.new do |spec|
  spec.name          = "objc"
  spec.version       = Objc::VERSION
  spec.authors       = ["Franklin Webber"]
  spec.email         = ["franklin.webber@gmail.com"]
  spec.description   = %q{This gem is a test suite runner for Objective-C files to allow for the easy
execution of a test suite without the hassle of managing an Xcode Project File. This allows you to work on your source files outside of a Xcode project but still have them tested. This is useful when when you want to practice Objective-C without the hassle of Xcode.}
  spec.summary       = %q{This gem is a test suite runner for Objective-C files to allow for the easy
execution of a test suite without the hassle of managing an Xcode Project File}
  spec.homepage      = "https://github.com/burtlo/objc"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "xcoder", "~> 0.1.15"
  spec.add_dependency "xcpretty", "~> 0.2.6"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake", "~> 11.2"

end
