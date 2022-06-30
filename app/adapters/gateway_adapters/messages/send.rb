# frozen_string_literal: true

module GatewayAdapters
  module Messages
    class Send < ::BaseGatewayAdapter
      def call(from, to, text)
        conn.post('messages', from:, to:, text:).then(&PULL_DATA)
      end
    end
  end
end
