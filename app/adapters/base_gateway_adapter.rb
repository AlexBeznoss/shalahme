# frozen_string_literal: true

class BaseGatewayAdapter
  ENDPOINT = 'https://api.telnyx.com/v2'

  def self.connection
    @connection ||= Faraday.new(
      url: ENDPOINT,
      headers: {
        'Content-Type' => 'application/json',
        'Accept' => 'application/json',
        'Authorization' => "Bearer #{Rails.application.credentials.dig(:telnyx, :key)}"
      }
    )
  end
end
