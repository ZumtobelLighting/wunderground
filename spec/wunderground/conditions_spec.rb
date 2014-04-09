require 'spec_helper'

describe Wunderground::Conditions, :vcr do
  it 'can get temperature from latitude, longitude' do
    conditions = Wunderground::Conditions.get(
      latitude: 42.34659958, 
      longitude: -71.04180145
    )

    expect(conditions.temperature_in_f).to_not be_nil
    expect(conditions.temperature_in_c).to_not be_nil
  end

  it 'can get temperature from city, state' do
    conditions = Wunderground::Conditions.get(
      city: 'Boston',
      state: 'MA'
    )

    expect(conditions.temperature_in_f).to_not be_nil
    expect(conditions.temperature_in_c).to_not be_nil
  end

  it 'can get humidity from latitude, longitude' do
    conditions = Wunderground::Conditions.get(
      latitude: 42.34659958, 
      longitude: -71.04180145
    )

    expect(conditions.humidity).to_not be_nil 
  end
end
