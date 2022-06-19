# frozen_string_literal: true

module GatewayAdapters
  module Numbers
    class Provision < ::BaseGatewayAdapter
      NoAvailableNumbersError = Class.new(::StandardError)

      def self.call(area_code)
        numbers = available_phone_numbers(area_code).then { |r| r.body['data'] }

        raise NoAvailableNumbersError, "area_code: #{area_code}" if numbers.empty?

        number_orders(numbers)
      end

      def self.available_phone_numbers(area_code)
        connection.get(
          'available_phone_numbers', {
            filter: {
              phone_number: { starts_with: area_code },
              country_code: 'US',
              features: %w[sms mms],
              limit: 1,
              best_effort: false
            }
          }
        )
      end

      def self.number_orders(numbers)
        connection.post(
          'number_orders', {
            phone_numbers: numbers
          }.to_json
        )
      end
    end
  end
end
