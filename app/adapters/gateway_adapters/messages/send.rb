# frozen_string_literal: true

module GatewayAdapters
  module Messages
    class Send < ::BaseGatewayAdapter
      def call(from, to, text)
        conn.post('messages', from:, to:, text:)
      end
    end
  end
end
