module Filters
  class NearbyCustomersFilter
    def initialize(office_lat:, office_lon:, max_distance_km:)
      @office_lat = office_lat
      @office_lon = office_lon
      @max_distance_km = max_distance_km
    end

    def call(records_enum)
      records_enum.select do |rec|
        d = Geo::Distance.distance_km(
          @office_lat, @office_lon,
          rec.latitude, rec.longitude
        )
        d <= @max_distance_km
      end
    end
  end
end
