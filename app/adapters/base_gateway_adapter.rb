# frozen_string_literal: true

class BaseGatewayAdapter
  PROVIDER_URL = 'https://api.telnyx.com/v2'
  PULL_DATA = ->(r) { r.body['data'] }

  def self.conn
    @conn ||= Faraday.new(PROVIDER_URL) do |f|
      f.request :json
      f.request :authorization, 'Bearer', Rails.application.credentials.dig(:telnyx, :token)

      f.response :json
      f.response :logger unless Rails.env.test?
      f.response :raise_error

      f.adapter :net_http
    end
  end

  def self.call(*args)
    new.call(*args).then(&PULL_DATA)
  end

  private

  def conn
    self.class.conn
  end
end
