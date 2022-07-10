# frozen_string_literal: true

source "https://rubygems.org"

gem "rake"

group :development do
  gem "guard"
  gem "guard-rspec"

  # RSpec formatter
  gem "fuubar", :require => false
end

group :test do
  gem "rspec"
  gem "rspec-its"

  gem "rubocop", "~> 1.31.2"
  gem "rubocop-performance"
  gem "rubocop-rake"
  gem "rubocop-rspec"
end

group :doc do
  gem "yard"
end

# Specify your gem"s dependencies in content-type.gemspec
gemspec
