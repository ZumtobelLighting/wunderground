require 'spec_helper'

describe Wunderground::Almanac, :vcr do
  it "can get historical weather data for today given latitude, longitude" do
    almanac = Wunderground::Almanac.get(
      latitude: 42.34659958, 
      longitude: -71.04180145
    )

    expect(almanac.average_high_in_c).to be_a(Float)
    expect(almanac.average_low_in_c).to be_a(Float)
  end

end
