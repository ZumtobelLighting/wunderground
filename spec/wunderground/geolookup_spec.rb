require 'spec_helper'

describe Wunderground::Geolookup, :vcr do
  context 'zip code to location' do
    it 'can get lat,long from zip code' do
      geolookup = Wunderground::Geolookup.get(zip: "02125")
      expect(geolookup.latitude).to eql("42.31518173")
      expect(geolookup.longitude).to eql("-71.05908203")
    end

    it 'can get state from zip code' do
      geolookup = Wunderground::Geolookup.get(zip: "34982")
      expect(geolookup.state).to eql("FL")
    end
  end
end
