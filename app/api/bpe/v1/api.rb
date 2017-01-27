# frozen_string_literal: true
module Bpe
  module V1
    class Api < Grape::API
      version 'v1', using: :path
      format :json

      rescue_from ActiveRecord::RecordNotFound do |error|
        error_response env['api.endpoint'].format_error(error.message, 404)
      end

      rescue_from ActiveRecord::RecordInvalid do |error|
        error_response(message: { errors: error.record.errors }, status: 422)
      end

      mount Bpe::V1::Vehicles
      mount Bpe::V1::States
    end
  end
end
