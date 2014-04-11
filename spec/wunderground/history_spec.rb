require 'spec_helper'

describe Wunderground::History, :vcr do
  it 'can retrive weather history given a location and date' do
    weather_history = Wunderground::History.get(
      city: 'Boston',
      state: 'MA',
      date: Date.new(2014, 1, 30)
    )

    expect(weather_history.observations).to be_an(Array)
  end

end
