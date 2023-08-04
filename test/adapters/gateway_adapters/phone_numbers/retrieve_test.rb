# frozen_string_literal: true

require 'test_helper'

class PhoneNumbersRetrieveAdapterTest < ActiveSupport::TestCase
  test 'nested from BaseGatewayAdapter' do
    adapter_class = GatewayAdapters::PhoneNumbers::Retrieve

    assert_equal adapter_class.superclass, BaseGatewayAdapter
  end

  test 'retrieves phone number' do
    id = '1293384261075731499'

    stub = stub_phone_numbers(id)

    GatewayAdapters::PhoneNumbers::Retrieve.call(id)

    assert_requested stub
  end

  def stub_phone_numbers(id, data: {})
    stub_request(:get, "https://api.telnyx.com/v2/phone_numbers/#{id}")
      .with(headers: request_headers)
      .to_return(status: 200, body: { data: }.to_json, headers: { content_type: 'application/json' })
  end

  def request_headers
    {
      'Accept' => '*/*',
      'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
      'Authorization' => /Bearer/,
      'User-Agent' => 'Faraday v2.3.0'
    }
  end
end
