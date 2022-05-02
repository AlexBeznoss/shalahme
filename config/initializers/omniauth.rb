# frozen_string_literal: true

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :developer if Rails.env.development?
  provider :google_oauth2,
           Rails.application.credentials.google[:key],
           Rails.application.credentials.google[:secret]
  provider :github,
           Rails.application.credentials.github[:key],
           Rails.application.credentials.github[:secret]
end

OmniAuth.config.allowed_request_methods = %i[get]
OmniAuth.config.test_mode = ENV['RAILS_ENV'] == 'test'
