module Wunderground
  class Conditions < Hash
    def temperature_in_c
      self['temp_c']
    end

    def temperature_in_f
      self['temp_f']
    end

    def humidity
      self['relative_humidity']
    end

    def method_missing(method, *args, &block)
      if self[method.to_s]
        self[method.to_s]
      else
        super
      end
    end

    class << self
      def get(*args)
        path = "#{Wunderground.base_path}/conditions/q/"

        args = args.reduce({}, :merge)

        if args.keys.include?(:latitude) and args.keys.include?(:longitude)
          path += "#{args[:latitude]},#{args[:longitude]}.json"

        elsif location = Wunderground::Geolookup.get(args)
          path += "#{location.latitude},#{location.longitude}.json"

        else
          raise "Conditions.get() does not understand #{args}"
        
        end

        result = Wunderground.connection.get(path)
        parsed_result = JSON.parse(result.body)

        if parsed_result and parsed_result["current_observation"]
          new.merge(parsed_result["current_observation"])
        end
      end
    end
  end
end
