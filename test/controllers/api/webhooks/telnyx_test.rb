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
      end
    end
  end
end
