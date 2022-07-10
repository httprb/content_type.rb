# frozen_string_literal: true

require_relative "./lib/content_type/version"

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
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "parslet", "~> 2.0"

  spec.add_development_dependency "bundler", "~> 2.0"
  spec.metadata["rubygems_mfa_required"] = "true"
end
