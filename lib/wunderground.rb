require 'json'
require 'faraday'
require 'wunderground/conditions'
require 'wunderground/geolookup'
require 'wunderground/version'

module Wunderground
  def self.base_path
    "/api/#{key}"
  end

  def self.key
    key = ENV['wunderground_key']
    if key.nil? or key.empty?
      raise 'Wunderground Error: No key defined! export wunderground_key="YOUR_API_KEY"'
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
