# coding: utf-8


require "content_type/parser"
require "content_type/version"


# ContentType structure
class ContentType
  attr_reader :type, :subtype, :parameters

  def initialize(parsed)
    parsed = [parsed] unless parsed.is_a? Array

    @type       = parsed.first[:type].to_s.downcase
    @subtype    = parsed.first[:subtype].to_s.downcase
    @parameters = Hash[parse_parameters parsed[1..-1]]
  end

  def mime_type
    "#{type}/#{subtype}"
  end

  def charset
    parameters["charset"]
  end

  def inspect
    "#<ContentType #{mime_type} #{parameters.inspect}>"
  end

  def to_s
    (["#{mime_type}"] + parameters.map { |k, v| "#{k}=#{v.to_s.inspect}" })
      .compact.join("; ")
  end
  alias :to_str :to_s

  def self.parse(str)
    new Parser.new.parse str
  end

  protected

  def parse_parameters(list)
    Array(list).map do |hash|
      [
        hash[:parameter][:attribute].to_s.downcase,
        hash[:parameter][:value].to_s
      ]
    end
  end
end
