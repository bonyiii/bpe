# frozen_string_literal: true
module Bpe
  module V1
    class Vehicles < Grape::API
      resource :vehicles do
        desc 'Return all Vehicles'
        get do
          vehicles = Vehicle.all

          { vehicles: vehicles.render(:index) }
        end

        desc 'Create new vehicle'
        params do
          requires :name, type: String, desc: 'Vehicle name'
        end
        post do
          vehicle = Vehicle.create!(params)

          { vehicle: vehicle.render(:detail) }
        end

        desc 'Read vehicle'
        route_param :id do
          get do
            vehicle = Vehicle.find(params[:id])

            { vehicle: vehicle.render(:detail) }
          end
        end

        desc 'Update vehicle'
        route_param :id do
          params do
            optional :name, type: String, desc: 'Vehicle name'
          end
          put do
            vehicle = Vehicle.find(params[:id])
            vehicle.update!(params)

            { vehicle: vehicle.render(:detail) }
          end
        end

        desc 'Delete vehicle'
        route_param :id do
          delete do
            vehicle = Vehicle.find(params[:id])
            vehicle.destroy!

            { result: 'Vehicle deleted' }.to_json
          end
        end

        desc 'Move vehicle to next state'
        route_param :id do
          put :next_state do
            vehicle = Vehicle.find(params[:id])
            vehicle.next_state!

            { vehicle: vehicle.render(:detail) }
          end
        end
      end
    end
  end
end
