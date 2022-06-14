# frozen_string_literal: true

module GatewayAdapters
  module NumberOrders
    class Retrieve < ::BaseGatewayAdapter

      def self.call(id)
        connection.get("number_orders/#{id}")
      end
    end
  end
end
