# frozen_string_literal: true

require 'test_helper'

class MessagesSendAdapterTest < ActiveSupport::TestCase
  test 'nested from BaseGatewayAdapter' do
    adapter_class = GatewayAdapters::Messages::Send

    assert_equal adapter_class.superclass, BaseGatewayAdapter
  end

  test 'requests message creation' do
    from = '+13115552368'
    to = '+13115552367'
    text = 'Message body'

    stub = stub_messages(from, to, text)

    GatewayAdapters::Messages::Send.call(from, to, text)

    assert_requested stub
  end

  def stub_messages(from, to, text, data: {})
    body = { from:, to:, text: }.to_json
    stub_request(:post, 'https://api.telnyx.com/v2/messages')
      .with(headers: request_headers, body:)
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
