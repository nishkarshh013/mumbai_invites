module Invitations
  class InviteNearbyCustomers
    class InvalidFileError < StandardError; end

    def initialize(io:, office_lat:, office_lon:, max_distance_km: 100.0)
      @io, @office_lat, @office_lon, @max_distance_km = io, office_lat, office_lon, max_distance_km
    end

    def call
      raise InvalidFileError, "Empty file" if @io.nil?

      parser = Parsers::CustomersJsonLines.new(@io)
      filter = Filters::NearbyCustomersFilter.new(
        office_lat: @office_lat, office_lon: @office_lon, max_distance_km: @max_distance_km
      )

      filter.call(parser)
        .sort_by(&:user_id)
        .map { |r| { user_id: r.user_id, name: r.name } }
    end
  end
end
