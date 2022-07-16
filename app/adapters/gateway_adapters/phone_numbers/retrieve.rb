# frozen_string_literal: true

module GatewayAdapters
  module PhoneNumbers
    class Retrieve < ::BaseGatewayAdapter
      def call(id)
        conn.get("phone_numbers/#{id}")
      end
    end
  end
end
