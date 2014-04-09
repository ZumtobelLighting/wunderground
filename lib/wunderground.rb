require "wunderground/version"
require 'wunderground/geolookup'

module Wunderground
  def self.base_path
    "/api/#{wunderground_key}"
  end

  def self.wunderground_key
    key = ENV['wunderground_key']
    if key.nil? or key.empty?
      raise 'Wunderground Error: No key defined! export wunderground_key="YOUR_API_KEY"'
    end
    key
  end
end
