# frozen_string_literal: true

require "parslet"

class ContentType
  # ContentType string parser
  class Parser < ::Parslet::Parser
    class Stri < ::Parslet::Atoms::Str # :nodoc:
      def initialize(*)
        super

        @pat = Regexp.new(@pat.source, Regexp::IGNORECASE)
      end
    end

    # rubocop:disable Layout/LineLength

    CHARS     = (0..127).map { |it| it.chr.freeze }.freeze
    CTLS      = [*(0..31), 127].map { |it| it.chr.freeze }.freeze
    SPACE     = " "
    HTAB      = 9.chr.freeze
    SPECIALS  = ["(", ")", "<", ">", "@", ",", ";", ":", "\\", "\"", ".", "[", "]"].freeze
    TSPECIALS = (SPECIALS | ["/", "?", "="]).freeze

    rule(:quoted_pair)    { str("\\") >> any_of(CHARS) }
    rule(:linear_ws)      { (str("\r\n").repeat(0, 1) >> (str(SPACE) | str(HTAB))).repeat(1) }
    rule(:qtext)          { any_of(CHARS - ["\"", "\\", "\r"]) }
    rule(:quoted_string)  { str("\"") >> (qtext | quoted_pair).repeat.as(:value) >> str("\"") }
    rule(:token)          { any_of(CHARS - [SPACE, *CTLS, *TSPECIALS]).repeat(1) }
    rule(:type_token)     { (any_of(CHARS - [SPACE, *CTLS, *TSPECIALS]) | str(".")).repeat(1) }
    rule(:space)          { str(SPACE) }

    # This could probably be simplified, in that as per RFC 6838 the entire expression could
    # just be `type_token`; the RFC names a partial but not exhaustive list of media type trees
    # and all of `x_token | vendor_token | prs_token` are really just `type_token`s in a first
    # place.
    rule(:x_token)       { stri("x-") >> type_token } # DEPRECATED - see RFC 6838
    rule(:vendor_token)  { stri("vnd.") >> type_token } # vendor tree - see RFC 6838
    rule(:prs_token)     { stri("prs.") >> type_token } # personal/vanity tree - see RFC 6838
    rule(:type)          { stri("application") | stri("audio") | stri("image") | stri("message") | stri("multipart") | stri("text") | stri("video") | x_token | vendor_token | prs_token }

    rule(:subtype)       { type_token }
    rule(:attribute)     { token }
    rule(:value)         { token.as(:value) | quoted_string }
    rule(:parameter)     { attribute.as(:attribute) >> str("=") >> value }
    rule(:parameters)    { space.repeat >> str(";") >> space.repeat >> parameter.as(:parameter) }
    rule(:content_type)  { type.as(:type) >> str("/") >> subtype.as(:subtype) >> parameters.repeat }

    root(:content_type)

    # rubocop:enable Layout/LineLength

    private

    def any_of(chars)
      chars.map { |char| str(char) }.inject(:|)
    end

    def stri(str)
      Stri.new(str)
    end
  end
end
