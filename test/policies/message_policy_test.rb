# frozen_string_literal: true

require 'test_helper'

module MessagePolicyTest
  class ReadTest < ActiveSupport::TestCase
    test 'returns true when user_phone_number belongs to user' do
      user = users(:github)
      user_phone_number = build(:user_phone_number, user_id: user.id)
      dialog = build(:dialog, user_phone_number:)
      message = build(:message, dialog:)

      policy = MessagePolicy.new(message, user:)

      assert_predicate policy, :read?
    end

    test 'returns false when user_phone_number not belongs to user' do
      user = users(:github)
      other_user = users(:google)
      user_phone_number = build(:user_phone_number, user_id: other_user.id)
      dialog = build(:dialog, user_phone_number:)
      message = build(:message, dialog:)

      policy = MessagePolicy.new(message, user:)

      assert_not policy.read?
    end
  end
end
