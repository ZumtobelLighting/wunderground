module Wunderground
  class History < Hash
    def method_missing(method, *args, &block)
      if self[method.to_s]
        self[method.to_s]
      else
        super
      end
    end

    class << self
      def get(*args)
        path = "#{Wunderground.base_path}/"

        args = args.reduce({}, :merge)

        if args.keys.include?(:date) and args[:date].is_a?(Date)
          date = args[:date].strftime("%Y%m%d")
          path += "history_#{date}/q/"

        else
          raise "History.get(): you must specifiy a date."

        end

        if args.keys.include?(:latitude) and args.keys.include?(:longitude)
          path += "#{args[:latitude]},#{args[:longitude]}.json"

        elsif location = Wunderground::Geolookup.get(args)
          path += "#{location.latitude},#{location.longitude}.json"

        else
          raise "History.get() does not understand #{args}"
        
        end

        result = Wunderground.connection.get(path)
        parsed_result = JSON.parse(result.body)

        if parsed_result and parsed_result["history"]
          new.merge(parsed_result["history"])
        end
      end
    end
  end 
end 
