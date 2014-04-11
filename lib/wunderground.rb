require 'json'
require 'faraday'
require 'wunderground/almanac'
require 'wunderground/astronomy'
require 'wunderground/conditions'
require 'wunderground/geolookup'
require 'wunderground/history'
require 'wunderground/version'

module Wunderground
  def self.base_path
    "/api/#{key}"
  end

  def self.key
    key = ENV['WUNDERGROUND_API_KEY']
    if key.nil? or key.empty?
      raise 'Wunderground Error: No key defined! export WUNDERGROUND_API_KEY="YOUR_API_KEY"'
    end
    key
  end

  protected
  def self.connection
    conn ||= Faraday.new(url: 'http://api.wunderground.com') do |faraday|
      faraday.request(:url_encoded)
      faraday.adapter(Faraday.default_adapter)
    end
  end
end
