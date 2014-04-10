require 'spec_helper'

describe Wunderground::Astronomy, :vcr do
  it 'can retrieve sunrise time for a location' do
    astronomy = Wunderground::Astronomy.get(
      city: 'Boston',
      state: 'MA'
    )
    expect(astronomy.sunrise).to be_a(Hash)
  end

  it 'can retrieve sunset time for a location' do
    astronomy = Wunderground::Astronomy.get(
      city: 'San Francisco',
      state: 'CA'
    )
    binding.pry
    expect(astronomy.sunset).to be_a(Hash)
  end

end
