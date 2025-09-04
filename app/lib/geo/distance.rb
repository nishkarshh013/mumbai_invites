# app/lib/geo/distance.rb
module Geo
  class Distance
    EARTH_RADIUS_KM = 6371.0

    def self.between(lat1, lon1, lat2, lon2)
      lat1_rad = to_radians(lat1)
      lon1_rad = to_radians(lon1)
      lat2_rad = to_radians(lat2)
      lon2_rad = to_radians(lon2)

      dlat = lat2_rad - lat1_rad
      dlon = lon2_rad - lon1_rad

      a = Math.sin(dlat / 2)**2 +
          Math.cos(lat1_rad) * Math.cos(lat2_rad) *
          Math.sin(dlon / 2)**2

      c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a))

      EARTH_RADIUS_KM * c
    end

    def self.distance_km(lat1, lon1, lat2, lon2)
      between(lat1, lon1, lat2, lon2)
    end

    def self.to_radians(degrees)
      degrees * Math::PI / 180.0
    end
  end
end
