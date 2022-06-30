# frozen_string_literal: true

require 'test_helper'

module Dialogs
  module CreateDialogTest
    class SuccessTest < ActiveSupport::TestCase
      setup do
        @recipient_phone = create(:recipient_phone_number)
        @user_phone = create(:user_phone_number)
      end

      test 'creates dialog when not exists' do
        assert_changes -> { Dialog.count }, from: 0, to: 1 do
          Dialogs::CreateDialog.call(
            recipient: @recipient_phone,
            user_phone_number: @user_phone
          )
        end

        dialog = Dialog.last
        assert_equal @recipient_phone, dialog.recipient_phone_number
        assert_equal @user_phone, dialog.user_phone_number
      end

      test 'adds dialog to context' do
        dialog = create(
          :dialog,
          recipient_phone_number: @recipient_phone,
          user_phone_number: @user_phone
        )

        interactor = Dialogs::CreateDialog.call(
          recipient: @recipient_phone,
          user_phone_number: @user_phone
        )

        assert_predicate interactor, :success?
        assert_equal dialog, interactor.dialog
      end

      test 'not creates dialog if exists' do
        create(:dialog, recipient_phone_number: @recipient_phone, user_phone_number: @user_phone)
        assert_no_changes -> { Dialog.count } do
          Dialogs::CreateDialog.call(
            recipient: @recipient_phone,
            user_phone_number: @user_phone
          )
        end
      end
    end

    class ErrorTest < ActiveSupport::TestCase
      setup do
        @recipient_phone = create(:recipient_phone_number)
        @user_phone = create(:user_phone_number)
      end

      test 'pass errors to fail' do
        errors = 'fake errors'
        dialog_mock = Minitest::Mock.new(errors:)
        dialog_mock.expect :errors, errors
        dialog_mock.expect :errors, errors

        Dialog.stub :create_or_find_by, dialog_mock do
          interactor = Dialogs::CreateDialog.call(
            recipient: @recipient_phone,
            user_phone_number: @user_phone
          )

          assert_not interactor.success?
          assert_equal errors, interactor.errors
        end
      end
    end
  end
end
