# frozen_string_literal: true
Rails.application.routes.draw do
  devise_for :users

  mount Bpe::V1::Api, at: '/api'

  authenticate :user do
    mount GrapeSwaggerRails::Engine => '/swagger'
  end

  #  unauthenticated :user do
  #    devise_scope :user do
  #      root 'devise/sessions#new', as: :unauthenticated_root
  #    end
  #  end

  root to: 'welcome#index'
  get '/*frontend', to: 'welcome#index'
end
