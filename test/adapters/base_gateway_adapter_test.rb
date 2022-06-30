# frozen_string_literal: true

require 'test_helper'

class BaseGatewayAdapterTest < ActiveSupport::TestCase
  class DummyAdapter < BaseGatewayAdapter
    def call
      conn.get('dummy')
    end
  end

  test 'returns pulled response data' do
    data = { 'id' => '1293384261075731499' }

    stub_dummy(data:)

    result = DummyAdapter.call

    assert_equal result, data
  end

  def stub_dummy(data: {})
    stub_request(:get, 'https://api.telnyx.com/v2/dummy')
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
