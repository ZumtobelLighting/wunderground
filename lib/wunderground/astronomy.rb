module Wunderground
  class Astronomy < Hash
    def sunrise
      { hour: self["sunrise"]["hour"], minute: self["sunrise"]["minute"] }
    end

    def sunset
      { hour: self["sunset"]["hour"], minute: self["sunset"]["minute"] }
    end

    class << self
      def get(*args)
        path = "#{Wunderground.base_path}/astronomy/q/"

        args = args.reduce({}, :merge)

        if location = Wunderground::Geolookup.get(args)
          path += "#{location.latitude},#{location.longitude}.json"

        else
          raise "Astronomy.get() does not understand #{args}"
        
        end

        result = Wunderground.connection.get(path)
        parsed_result = JSON.parse(result.body)

        if parsed_result and parsed_result["moon_phase"]
          parsed_result["moon_phase"]["time_zone"] = location["tz_short"]
          new.merge(parsed_result["moon_phase"])
        end
      end
    end
  end

end
