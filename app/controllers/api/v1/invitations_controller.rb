module Api
  module V1
    class InvitationsController < ApplicationController
      def create
        file = params.require(:file)

        unless file.respond_to?(:read)
          return render json: { error: "Invalid file upload" }, status: :unprocessable_entity
        end

        service = Invitations::InviteNearbyCustomers.new(
          io: file.tempfile || file,
          office_lat: 19.0590317,
          office_lon: 72.7553452,
          max_distance_km: 100.0
        )

        result = service.call
        render json: { customers: result }, status: :ok
      rescue ActionController::ParameterMissing => e
        render json: { error: e.message }, status: :bad_request
      rescue Invitations::InviteNearbyCustomers::InvalidFileError => e
        render json: { error: e.message }, status: :unprocessable_entity
      end
    end
  end
end
