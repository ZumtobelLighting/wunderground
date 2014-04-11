module Wunderground
  class Almanac < Hash
    def average_high_in_c 
      self['temp_high']['normal']['C'].to_f
    end

    def average_high_in_f 
      self['temp_high']['normal']['F'].to_f
    end

    def average_low_in_c 
      self['temp_low']['normal']['C'].to_f
    end

    def average_low_in_f 
      self['temp_low']['normal']['F'].to_f
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
        path = "#{Wunderground.base_path}/almanac/q/"

        args = args.reduce({}, :merge)

        if args.keys.include?(:latitude) and args.keys.include?(:longitude)
          path += "#{args[:latitude]},#{args[:longitude]}.json"

        elsif location = Wunderground::Geolookup.get(args)
          path += "#{location.latitude},#{location.longitude}.json"

        else
          raise "Almanac.get() does not understand #{args}"
        
        end

        result = Wunderground.connection.get(path)
        parsed_result = JSON.parse(result.body)

        if parsed_result and parsed_result["almanac"]
          new.merge(parsed_result["almanac"])
        end
      end
    end
  end 
end 
