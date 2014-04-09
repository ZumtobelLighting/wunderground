require 'rspec'

describe Wunderground::Geolookup do
  context 'zip code to location' do
    it 'can get lat,long from zip code' do
      geolookup = Wudnerground::Geolookup.new(zip: 02125)
      expect(geolookup.latitude).to eql(42.31518173)
      expect(geolookup.longitude).to eql(-71.05908203)
    end
  end
end
