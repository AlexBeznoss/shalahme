# frozen_string_literal: true

require 'test_helper'

class MessageTest < ActiveSupport::TestCase
  test 'updates unread_messages_count in dialog' do
    dialog = create(:dialog)
    message1 = create(:message, dialog:)
    create(:message, dialog:, read: true)
    message2 = create(:message, dialog:)

    assert_equal 2, dialog.reload.unread_messages_count
    message1.update!(read: true)

    assert_equal 1, dialog.reload.unread_messages_count

    message2.update!(read: true)

    assert_equal 0, dialog.reload.unread_messages_count
  end
end
