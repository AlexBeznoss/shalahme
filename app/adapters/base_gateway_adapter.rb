# frozen_string_literal: true

class BaseGatewayAdapter
  PROVIDER_URL = 'https://api.telnyx.com/v2'

  def self.connection
    @connection ||= Faraday.new(PROVIDER_URL) do |f|
      f.request :json
      f.request :authorization, 'Bearer', Rails.application.credentials.dig(:telnyx, :token)

      f.response :json
      f.response :logger

      f.adapter :net_http
    end
  end
end
