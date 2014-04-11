# Wunderground

A wrapper for the Weather Underground API written in ruby.

## Installation

Add this line to your application's Gemfile:

    gem 'wunderground', git: 'git://github.com/radavis/wunderground.git'

And then execute:

    $ bundle

## Usage

Define your api key in your environment: ```export WUNDERGROUND_API_KEY="YOUR_API_KEY"```

```
almanac = Wunderground::Almanac.get(
  latitude: 42.34659958, 
  longitude: -71.04180145
)
almanac.average_high_in_c => 12.0
almanac.average_low_in_c => 4.0
almanac.average_high_in_f => 53.0
almanac.average_low_in_f => 39.0

astronomy = Wunderground:Astronomy.get(
  city: 'Boston',
  state: 'MA'
)
astronomy.sunrise => { hour: 6, minute: 11 }
astronomy.sunset => { hour: 19, minute: 20 }

conditions = Wunderground::Conditions.get(
  latitude: 42.31518173, 
  longitude: -71.05908203
)  # or geolookup inputs
conditions.temperature_in_c => 30
conditions.temperature_in_f => 70
conditions.wind_kph => 4
conditions.humidity => 65

geolookup = Wunderground::Geolookup.get(zip: 02125)  # or ip, city+state, country+city, airport, lat+lon
geolookup.state => 'MA'
geolookup.city => 'Dorchester'
geolookup.coordinates => { latitude: 42.31518173, longitude: -71.05908203 }

weather_history = Wunderground::History.get(
  city: 'Boston',
  state: 'MA',
  date: Date.new(2014, 1, 30)
)
weather_history.observations => # array of observations
...
```

[Glossary of Wunderground field names](http://www.wunderground.com/weather/api/d/docs?d=resources/phrase-glossary)

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## To Do

  * Retrieve detailed historical data for a location
  * Create base request class
