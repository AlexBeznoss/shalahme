# frozen_string_literal: true

require 'test_helper'

module Dialogs
  module FindUserNumberTest
    class SuccessTest < ActiveSupport::TestCase
      test 'adds user_phone_number to context' do
        user = create(:user)
        number = create(:user_phone_number, :ready, user:)

        interactor = Dialogs::FindUserNumber.call(user:, params: { user_number_id: number.id })

        assert_predicate interactor, :success?
        assert_equal number, interactor.user_phone_number
      end
    end

    class ErrorTest < ActiveSupport::TestCase
      setup { @user = create(:user) }

      test 'fails when status not ready' do
        %i[draft error].each do |status|
          number = create(:user_phone_number, user: @user, status:)
          params = { user_phone_number: number.id }

          assert_not Dialogs::FindUserNumber.call(user: @user, params:).success?
        end
      end

      test 'fails when number discarded' do
        number = create(:user_phone_number, :ready, user: @user, discarded_at: Time.current)
        params = { user_phone_number: number.id }

        assert_not Dialogs::FindUserNumber.call(user: @user, params:).success?
      end

      test 'fails when not belongs to user' do
        other_user = create(:user)
        number = create(:user_phone_number, :ready, user: other_user)
        params = { user_phone_number: number.id }

        assert_not Dialogs::FindUserNumber.call(user: @user, params:).success?
      end

      test 'adds error' do
        UserPhoneNumber.stub :find_by, nil do
          expected_errors = ['Your number is not accessible right now, try again later.']
          errors = []

          interactor = Dialogs::FindUserNumber.call(user: @user, params: { user_phone_number: "doesn't matter" })
          interactor.errors.each { |e| errors << e }

          assert_equal expected_errors, errors.map(&:full_message)
          assert interactor.errors.has_key?(:user_number_id) # rubocop:disable Style/PreferredHashMethods
        end
      end
    end
  end
end
