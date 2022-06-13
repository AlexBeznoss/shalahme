# frozen_string_literal: true

class GatewayAdapter
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

  def self.provision_phone_number(area_code)
    numbers = connection.get(
      'available_phone_numbers', {
        filter: {
          country_code: 'US',
          best_effort: false,
          features: %w[sms mms],
          limit: 1,
          phone_number: {
            starts_with: area_code
          }
        }
      }
    )

    number = JSON.parse(numbers.body)['data'][0]['phone_number']

    connection.post(
      'number_orders', {
        phone_numbers: [{ phone_number: number }]
      }.to_json
    )
  end

  # def provision_phone_number(area_code)
  # numbers = connection.get("/search",
  # limit: 1,
  # phone_number_type: "mobile",
  # features: [ "sms", "mms" ])

  # raise NoAvailableNumbers.new("area_code: #{area_code}") unless numbers

  # connection.post("order_phone_number")

  # raise NumberNotAvalable.new("number: #{number}") if something
  # true
  # end

  def sent_message; end

  def fetch_message; end
end
