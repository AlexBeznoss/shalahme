# frozen_string_literal: true

module GatewayAdapters
  module NumberOrders
    class Retrieve < ::BaseGatewayAdapter
      def call(id)
        conn.get("number_orders/#{id}").then(&PULL_DATA)
      end
    end
  end
end
