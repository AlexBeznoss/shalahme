# frozen_string_literal: true

require 'test_helper'

module Api
  module Webhooks
    module TelnyxControllerTest
      class CreateTest < ActionDispatch::IntegrationTest
        test 'returns success' do
          post '/api/webhooks/telnyx'

          assert_response :ok
        end

        test 'handles number_order.complete' do
          user = users(:google)
          number = user.phone_numbers.create!

          post '/api/webhooks/telnyx'

          assert_equal(:ready, number.reload.status)
        end
      end
    end
  end
end
