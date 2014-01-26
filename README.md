# Content::Type

RFC-compliant Content-Type parser.

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

## Contributing

1. Fork it ( http://github.com/<my-github-username>/content-type/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
