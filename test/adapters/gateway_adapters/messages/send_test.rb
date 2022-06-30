# frozen_string_literal: true

require 'test_helper'

class MessagesSendAdapterTest < ActiveSupport::TestCase
  test 'requests message creation' do
    from = '+13115552368'
    to = '+13115552367'
    text = 'Message body'

    stub = stub_messages(from, to, text)

    GatewayAdapters::Messages::Send.call(from, to, text)

    assert_requested stub
  end

  test 'returns pulled response data' do
    from = '+13115552368'
    to = '+13115552367'
    text = 'Message body'
    data = { 'id' => '40385f64-5717-4562-b3fc-2c963f66afa6' }

    stub_messages(from, to, text, data:)

    result = GatewayAdapters::Messages::Send.call(from, to, text)

    assert_equal result, data
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
