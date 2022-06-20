# frozen_string_literal: true

module GatewayAdapters
  module Numbers
    class Provision < ::BaseGatewayAdapter
      NoAvailableNumbersError = Class.new(::StandardError)

      def call(area_code)
        numbers = available_phone_numbers(area_code).then(&PULL_DATA)

        raise NoAvailableNumbersError, "area_code: #{area_code}" if numbers.empty?

        number_orders(numbers)
      end

      private

      def available_phone_numbers(area_code)
        conn.get(
          'available_phone_numbers',
          filter: {
            phone_number: { starts_with: area_code },
            country_code: 'US',
            features: %w[sms mms],
            limit: 1,
            best_effort: false
          }
        )
      end

      def number_orders(numbers)
        conn.post('number_orders', phone_numbers: numbers)
      end
    end
  end
end
