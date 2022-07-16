# frozen_string_literal: true

require 'test_helper'

module PhoneNumbers
  class UpdateStatusJobTest < ActiveJob::TestCase
    test 'updates number status' do
      sid = 'number_id'
      user = users(:google)
      number = user
               .phone_numbers
               .create!(sid:, status: :draft, name: 'test', area_code: '877')

      adapter = GatewayAdapters::PhoneNumbers::Retrieve
      adapter.expects(:call).with(sid).returns({ status: 'ready' })

      PhoneNumbers::UpdateStatusJob.perform_now(sid)

      assert_equal('ready', number.reload.status)
    end
  end
end
