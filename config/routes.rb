# frozen_string_literal: true
Rails.application.routes.draw do
  devise_for :users

  mount Bpe::V1::Api, at: '/api'

  authenticate :user do
    mount GrapeSwaggerRails::Engine => '/swagger'
  end

  root to: 'welcome#index'
end
