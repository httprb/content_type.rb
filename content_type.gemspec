# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "content_type/version"

Gem::Specification.new do |spec|
  spec.name          = "content-type"
  spec.version       = ContentType::VERSION
  spec.homepage      = "https://github.com/httprb/content-type"
  spec.authors       = ["Aleksey V Zapparov"]
  spec.email         = ["ixti@member.fsf.org"]
  spec.license       = "MIT"
  spec.summary       = "content-type-#{ContentType::VERSION}"
  spec.description   = "HTTP ContentType header parser"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(/^bin\//).map { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(/^(test|spec|features)\//)
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "parslet", "~> 1.5.0"

  spec.add_development_dependency "bundler", "~> 1.7"
end
