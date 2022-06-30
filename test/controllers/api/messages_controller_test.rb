# frozen_string_literal: true

require 'test_helper'
require 'test_helpers/authentication'
require 'action_policy/test_helper'

module Api
  module MessagesControllerTest
    class ReadTest < ActionDispatch::IntegrationTest
      include Authentication
      include ActionPolicy::TestHelper

      test 'requires authentication' do
        assert_api_requires_authentication_for(
          :post, '/api/messages/1/read'
        )
      end

      test 'requires authorization' do
        message = create(:message)

        sign_in(users(:github))
        assert_authorized_to(:read?, message, with: MessagePolicy) do
          post "/api/messages/#{message.id}/read"
        end
      end

      test 'calls Messages::Read' do
        user = users(:github)
        number = create(:user_phone_number, user:)
        dialog = create(:dialog, user_phone_number: number)
        message = create(:message, dialog:)

        Messages::Read.expects(:call).with(message:, current_user: user).at_least_once

        sign_in(user)
        post "/api/messages/#{message.id}/read"
      end

      test 'returns success' do
        user = users(:github)
        number = create(:user_phone_number, user:)
        dialog = create(:dialog, user_phone_number: number)
        message = create(:message, dialog:)

        Messages::Read.expects(:call)

        sign_in(user)
        post "/api/messages/#{message.id}/read"

        assert_response :ok
      end
    end
  end
end
