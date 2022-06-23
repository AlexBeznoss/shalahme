# frozen_string_literal: true

module GatewayAdapters
  module Messages
    class Retrieve < ::BaseGatewayAdapter
      def call(id)
        conn.get("messages/#{id}").then(&PULL_DATA)
      end
    end
  end
end
