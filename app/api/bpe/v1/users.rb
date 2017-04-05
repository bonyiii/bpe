# frozen_string_literal: true

module Bpe
  module V1
    class Users < Grape::API
      resource :users do
        desc 'Return current suer'
        get do
          { user: current_user.render(:index) }
        end
      end
    end
  end
end
