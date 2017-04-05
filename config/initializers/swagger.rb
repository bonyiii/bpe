# frozen_string_literal: true

GrapeSwaggerRails.options.url      = '/swagger_doc.json'
GrapeSwaggerRails.options.app_url  = ENV['SWAGGER_URL']
GrapeSwaggerRails.options.before_action do |_request|
  # This not needed since it is handled in config/routes.rb
  redirect_to new_user_session_path unless current_user
end
