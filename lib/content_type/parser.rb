# coding: utf-8


# 3-rd party
require "parslet"


class ContentType
  # ContentType string parser
  class Parser < ::Parslet::Parser
    class CharList # :nodoc:
      def initialize(list = nil)
        @list = list || yield
      end

      def -(other)
        CharList.new @list - other.to_a
      end

      def +(other)
        CharList.new @list + other.to_a
      end

      def to_a
        @list.dup
      end
      alias :to_ary :to_a

      def to_s
        @list.join
      end
      alias :to_str :to_s

      def size
        to_s.size
      end
    end


    def stri(s)
      s.split(//).map { |c| match["#{c.upcase}#{c.downcase}"] }.reduce :>>
    end


    # rubocop:disable LineLength
    # rubocop:disable Blocks
    # rubocop:disable BlockAlignment

    CHAR      = CharList.new { (0..127).to_a.map(&:chr) }
    CTLS      = CharList.new { (0..31).to_a.map(&:chr) << 127.chr }
    CR        = CharList.new { [13.chr] }
    LF        = CharList.new { [10.chr] }
    SPACE     = CharList.new { [" "] }
    HTAB      = CharList.new { [9.chr] }
    CRLF      = CharList.new { [13.chr + 10.chr] }
    SPECIALS  = CharList.new { ["(", ")", "<", ">", "@", ",", ";", ":", "\\", "\"", ".", "[", "]"] }
    TSPECIALS = CharList.new { SPECIALS + ["/", "?", "="] }

    rule(:quoted_pair)    { str("\\") >> match[Regexp.escape CHAR] }
    rule(:linear_ws)      { (str(CRLF).repeat(0, 1) >> (str(SPACE) | str(HTAB))).repeat(1) }
    rule(:qtext)          { match[Regexp.escape CHAR - ["\"", "\\"] - CR] }
    rule(:quoted_string)  { str('"') >> (qtext | quoted_pair).repeat.as(:value) >> str("\"") }
    rule(:token)          { match[Regexp.escape CHAR - SPACE - CTLS - TSPECIALS].repeat(1) }
    rule(:space)          { str(SPACE) }
    rule(:x_token)        { stri("x") >> str("-") >> token }
    rule(:type)           { stri("application") | stri("audio") | stri("mage") | stri("message") | stri("multipart") | stri("text") | stri("video") | x_token }
    rule(:subtype)        { token }
    rule(:attribute)      { token }
    rule(:value)          { token.as(:value) | quoted_string }
    rule(:parameter)      { attribute.as(:attribute) >> str("=") >> value }
    rule(:parameters)     { space.repeat >> str(";") >> space.repeat >> parameter.as(:parameter) }
    rule(:content_type)   { type.as(:type) >> str("/") >> subtype.as(:subtype) >> parameters.repeat }
    root(:content_type)
  end
end
