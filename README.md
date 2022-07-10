# ContentType

[![Gem Version][gem-image]][gem-link]
[![MIT licensed][license-image]][license-link]
[![CI Status][ci-image]][ci-link]

[RFC][]-compliant HTTP Content-Type parser.


## Installation

Add this line to your application's Gemfile:

    gem 'content-type'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install content-type


## Usage

``` ruby
content_type = ContentType.parse "application/JSON; charset=utf-8; foo=bar"
content_type.mime_type              # => "application/json"
content_type.type                   # => "application"
content_type.subtype                # => "json"
content_type.charset                # => "utf-8"
content_type.parameters["charset"]  # => "utf-8"
content_type.parameters["foo"]      # => "bar"
```


## Supported Ruby Versions

This library aims to support and is [tested against][ci-link] the following Ruby
versions:

* Ruby 2.6
* Ruby 2.7
- Ruby 3.0
- Ruby 3.1

If something doesn't work on one of these versions, it's a bug.

This library may inadvertently work (or seem to work) on other Ruby versions,
however support will only be provided for the versions listed above.

If you would like this library to support another Ruby version or
implementation, you may volunteer to be a maintainer. Being a maintainer
entails making sure all tests run and pass on that implementation. When
something breaks on your implementation, you will be responsible for providing
patches in a timely fashion. If critical issues for a particular implementation
exist at the time of a major release, support for that Ruby version may be
dropped.


## Contributing

1. Fork it ( http://github.com/httprb/content-type/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request


## Copyright

Copyright © 2015-2022 Alexey Zapparov.
See LICENSE.txt for further details.


[//]: # (badges)

[gem-image]: https://img.shields.io/gem/v/content-type?logo=ruby
[gem-link]: https://rubygems.org/gems/content-type
[license-image]: https://img.shields.io/badge/license-MIT-blue.svg
[license-link]: https://github.com/httprb/content-type.rb/blob/main/LICENSE.txt
[ci-image]: https://github.com/httprb/content-type.rb/workflows/CI/badge.svg
[ci-link]: https://github.com/httprb/content-type.rb/actions/workflows/ci.yml

[//]: # (links)

[RFC]: http://tools.ietf.org/html/rfc2045#section-5.1
