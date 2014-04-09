require 'spec_helper'

describe Wunderground::Geolookup, :vcr do
  it 'can get latitude, longitude from city, state' do
    geolookup = Wunderground::Geolookup.get(
      city: "San Francisco", 
      state: "CA"
    )

    expect(geolookup.latitude).to eql(37.77500916)
    expect(geolookup.longitude).to eql(-122.41825867)
  end

  it 'can get city, state from ip' do
    geolookup = Wunderground::Geolookup.autoip
    expect(geolookup.city).to_not be_nil
    expect(geolookup.state).to_not be_nil
  end

  it 'can get latitude, longitude from airport code' do
    geolookup = Wunderground::Geolookup.get(airport: 'BOS')
    expect(geolookup.latitude).to eql(42.36416626)
    expect(geolookup.longitude).to eql(-71.00499725)
    expect(geolookup.city).to eql("Logan International")
  end

  it 'can get latitude, longitude from zip code' do
    geolookup = Wunderground::Geolookup.get(zip: "02210")
    expect(geolookup.latitude).to eql(42.34659958)
    expect(geolookup.longitude).to eql(-71.04180145)
  end

  it 'can get city, state from zip code' do
    geolookup = Wunderground::Geolookup.get(zip: "33133")
    expect(geolookup.state).to eql("FL")
    expect(geolookup.city).to eql("Miami")
  end

  it 'can get city, state from latitude, longitude' do
    geolookup = Wunderground::Geolookup.get(
      latitude: 42.34659958 , 
      longitude: -71.04180145
    )

    expect(geolookup.city).to eql("Boston")
    expect(geolookup.state).to eql("MA")
  end
end
