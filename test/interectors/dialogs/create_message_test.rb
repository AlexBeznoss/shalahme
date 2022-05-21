# frozen_string_literal: true

require 'test_helper'

module Dialogs
  module CreateMessageTest
    class SuccessTest < ActiveSupport::TestCase
      setup do
        @dialog = create(:dialog)
      end

      test 'creates message' do # rubocop:disable Minitest/MultipleAssertions
        content = 'Fake content'

        assert_changes -> { Message.count }, from: 0, to: 1 do
          Dialogs::CreateMessage.call(
            dialog: @dialog,
            params: { content: }
          )
        end

        message = Message.last
        assert message.read
        assert_equal content, message.content
        assert_equal @dialog, message.dialog
        assert_equal('outbound', message.direction)
        assert_equal('sms', message.kind)
      end

      test 'be successfull' do
        interactor = Dialogs::CreateMessage.call(
          dialog: @dialog,
          params: { content: 'Fake content' }
        )

        assert_predicate interactor, :success?
      end
    end

    class ErrorTest < ActiveSupport::TestCase
      setup do
        @dialog = create(:dialog)
      end

      test 'pass errors to fail' do
        interactor = Dialogs::CreateMessage.call(
          dialog: @dialog,
          params: {}
        )

        assert_not interactor.success?
        assert_equal :content, interactor.errors.first.attribute
      end
    end
  end
end
