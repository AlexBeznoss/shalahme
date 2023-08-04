# frozen_string_literal: true

module PhoneNumbers
  class UpdateStatusJob < ApplicationJob
    queue_as :default

    def perform(sid)
      number = UserPhoneNumber.find_by!(sid:)

      retrieved_number = GatewayAdapters::PhoneNumbers::Retrieve.call(sid)

      number.update!(status: retrieved_number[:status])
    end
  end
end
