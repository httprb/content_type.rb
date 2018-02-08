source "https://rubygems.org"

group :development do
  gem "rake", "~> 12.3"
  gem "guard"
  gem "guard-rspec", :require => false
end

group :test do
  gem "coveralls"
  gem "rspec",      "~> 3.1"
  gem "rspec-its"
  gem "simplecov",  ">= 0.9"
  gem "rubocop",    "~> 0.52.0"
end

group :doc do
  gem "yard"
  gem "redcarpet"
end

platforms :rbx do
  gem "racc"
  gem "rubinius-coverage", "~> 2.0"
  gem "rubysl", "~> 2.0"
end

# Specify your gem"s dependencies in content-type.gemspec
gemspec
