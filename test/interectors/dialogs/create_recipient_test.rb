# frozen_string_literal: true

require 'test_helper'

module Dialogs
  module CreateRecipientTest
    class SuccessTest < ActiveSupport::TestCase
      test 'creates recipient when not exists' do
        number = '+1232232323'
        assert_changes -> { RecipientPhoneNumber.count }, from: 0, to: 1 do
          Dialogs::CreateRecipient.call(
            params: { number: }
          )
        end

        recipient = RecipientPhoneNumber.last
        assert_equal number, recipient.number
      end

      test 'adds recipient to context' do
        recipient = create(:recipient_phone_number)

        interactor = Dialogs::CreateRecipient.call(params: { number: recipient.number })

        assert_predicate interactor, :success?
        assert_equal recipient, interactor.recipient
      end

      test 'not creates dialog if exists' do
        recipient = create(:recipient_phone_number)
        assert_no_changes -> { RecipientPhoneNumber.count } do
          Dialogs::CreateRecipient.call(params: { number: recipient.number })
        end
      end
    end

    class ErrorTest < ActiveSupport::TestCase
      test 'pass errors to fail' do
        interactor = Dialogs::CreateRecipient.call(params: {})

        assert_not interactor.success?
        assert_equal :number, interactor.errors.first.attribute
      end
    end

    class RollbackTest < ActiveSupport::TestCase
      setup do
        @recipient_phone = create(:recipient_phone_number)
        @interactor = Dialogs::CreateRecipient.new(recipient: @recipient_phone)
      end

      test 'destroys recipient if no dialogs' do
        assert_changes -> { RecipientPhoneNumber.count }, from: 1, to: 0 do
          @interactor.rollback
        end
      end

      test 'not destroys recipient if there are dialogs' do
        create(:dialog, recipient_phone_number: @recipient_phone)
        assert_no_changes -> { Dialog.count } do
          @interactor.rollback
        end
      end
    end
  end
end
