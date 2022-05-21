# frozen_string_literal: true

class Message < ApplicationRecord
  belongs_to :dialog

  counter_culture(
    :dialog,
    column_name: proc { |m| m.read? ? nil : :unread_messages_count }
  )

  enum status: {
    draft: 0,
    queued: 10,
    failed: 20,
    sent: 30,
    delivered: 40,
    undelivered: 50
  }
  enum direction: {
    outbound: 0,
    inbound: 10
  }
  enum kind: {
    sms: 0,
    mms: 10
  }

  validates :content, presence: true, length: { maximum: 1600 }
end
