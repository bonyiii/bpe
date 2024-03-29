# frozen_string_literal: true

module Bpe
  module V1
    class Api < Grape::API
      version 'v1', using: :path
      format :json

      rescue_from ActiveRecord::RecordNotFound do
        error_response message: 'Record not found!', status: 404
      end

      # :nocov:
      rescue_from ActiveRecord::RecordInvalid, ActiveRecord::RecordNotDestroyed do |error|
        error_response(message: { errors: error.record.errors }, status: 422)
      end
      # :nocov:

      rescue_from Pundit::NotAuthorizedError do |error|
        error_response(message: { errors: error }, status: 403)
      end

      helpers do
        def current_user
          env['warden'].user
        end

        def authenticate!
          return true if current_user
          error!('401 Unauthorized', 401)
        end
      end

      before do
        authenticate!
        extend Pundit
      end

      mount Bpe::V1::Vehicles
      mount Bpe::V1::States
      mount Bpe::V1::Users

      add_swagger_documentation
    end
  end
end
