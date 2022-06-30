# frozen_string_literal: true

require 'test_helper'

class NumberOrdersRetrieveAdapterTest < ActiveSupport::TestCase
  test 'retrieves number order' do
    id = '1293384261075731499'

    stub = stub_number_orders(id)

    GatewayAdapters::NumberOrders::Retrieve.call(id)

    assert_requested stub
  end

  test 'returns pulled response data' do
    id = '1293384261075731499'
    data = { 'id' => id }

    stub_number_orders(id, data:)

    result = GatewayAdapters::NumberOrders::Retrieve.call(id)

    assert_equal result, data
  end

  def stub_number_orders(id, data: {})
    stub_request(:get, "https://api.telnyx.com/v2/number_orders/#{id}")
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
