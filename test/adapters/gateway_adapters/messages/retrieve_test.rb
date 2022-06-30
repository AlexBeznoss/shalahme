# frozen_string_literal: true

require 'test_helper'

class MessagesRetrieveAdapterTest < ActiveSupport::TestCase
  test 'nested from BaseGatewayAdapter' do
    adapter_class = GatewayAdapters::Messages::Retrieve

    assert_equal adapter_class.superclass, BaseGatewayAdapter
  end

  test 'requests message creation' do
    id = '40385f64-5717-4562'

    stub = stub_messages(id)

    GatewayAdapters::Messages::Retrieve.call(id)

    assert_requested stub
  end

  def stub_messages(id, data: {})
    stub_request(:get, "https://api.telnyx.com/v2/messages/#{id}")
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
