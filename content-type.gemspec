# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'content_type/version'

Gem::Specification.new do |spec|
  spec.name          = "content-type"
  spec.version       = ContentType::VERSION
  spec.authors       = ["Aleksey V Zapparov"]
  spec.email         = ["ixti@member.fsf.org"]
  spec.summary       = "content-type-#{ContentType::VERSION}"
  spec.description   = %q{ContentType parser}
  spec.homepage      = "https://github.com/ixti/content-type"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "parslet", "~> 1.5"

  spec.add_development_dependency "bundler", "~> 1.5"
end
