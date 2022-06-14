# frozen_string_literal: true

require 'test_helper'

class NumberOrdersRetrieveAdapterTest < ActiveSupport::TestCase
  test 'retrieves number order' do
    id = '1293384261075731499'

    stub = stub_number_orders(id)

    GatewayAdapters::NumberOrders::Retrieve.call(id)

    assert_requested stub
  end

  def stub_number_orders(id)
    stub_request(:get, "https://api.telnyx.com/v2/number_orders/#{id}").
      with(
      headers: request_headers
    ).to_return(status: 200, body: {}.to_json)
  end

  def request_headers
    {
      'Accept' => 'application/json',
      'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
      'Authorization' => /Bearer/,
      'Content-Type' => 'application/json',
      'User-Agent' => 'Faraday v2.3.0'
    }
  end
end
