module Wunderground
  class Geolookup < Hash
    def latitude
      self['lat'].to_f
    end

    def longitude
      self['lon'].to_f
    end

    def coordinates
      { latitude: latitude, longitude: longitude }
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
        path = "#{Wunderground.base_path}/geolookup/q/"

        args = args.reduce({}, :merge)
        
        if args.keys.include?(:state) and args.keys.include?(:city)
          path += "#{args[:state]}/#{args[:city].gsub(' ', '_')}.json"

        elsif args.keys.include?(:country) and args.keys.include?(:city)
          path += "#{args[:country].gsub(' ', '_')}/#{args[:city].gsub(' ', '_')}.json"

        elsif args.keys.include?(:autoip)
          path += "autoip.json"

        elsif args.keys.include?(:ip)
          path += "autoip.json?geo_ip=#{args[:ip]}"

        elsif args.keys.include?(:zip) 
          path += "#{args[:zip]}.json"

        elsif args.keys.include?(:airport)
          path += "#{args[:airport]}.json"

        elsif args.keys.include?(:latitude) and args.keys.include?(:longitude)
          path += "#{args[:latitude]},#{args[:longitude]}.json"

        elsif args.keys.include?(:pws)
          path += "pws:#{args[:pws]}.json"

        else
          raise "Geolookup.get() does not understand #{args}"

        end

        result = Wunderground.connection.get(path)
        parsed_result = JSON.parse(result.body)

        if parsed_result and parsed_result["location"]
          new.merge(parsed_result["location"])
        else 
          nil
        end
      end

      def autoip
        get(autoip: true)
      end
    end
  end
end
