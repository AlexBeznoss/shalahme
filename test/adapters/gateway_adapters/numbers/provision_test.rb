# frozen_string_literal: true

require 'test_helper'

class NumbersProvisionAdapterTest < ActiveSupport::TestCase
  test 'nested from BaseGatewayAdapter' do
    adapter_class = GatewayAdapters::Numbers::Provision

    assert_equal adapter_class.superclass, BaseGatewayAdapter
  end

  test 'requests available numbers' do
    area_code = '850'
    number = '+18503608622'

    stub = stub_available_numbers(area_code, number)
    stub_number_orders(number)

    GatewayAdapters::Numbers::Provision.call(area_code)

    assert_requested stub
  end

  test 'requests number order' do
    area_code = '850'
    number = '+18503608622'

    stub_available_numbers(area_code, number)
    stub = stub_number_orders(number)

    GatewayAdapters::Numbers::Provision.call(area_code)

    assert_requested stub
  end

  test 'raises NoAvailableNumbersError if no numbers' do
    area_code = '850'

    stub_available_numbers(area_code, nil)

    error = assert_raises(GatewayAdapters::Numbers::Provision::NoAvailableNumbersError) do
      GatewayAdapters::Numbers::Provision.call(area_code)
    end

    assert_equal "area_code: #{area_code}", error.message
  end

  def stub_available_numbers(area_code, number)
    data = number ? [{ phone_number: number }] : []
    stub_request(:get, 'https://api.telnyx.com/v2/available_phone_numbers')
      .with(query: { 'filter[phone_number][starts_with]' => area_code,
                     'filter[country_code]' => 'US',
                     'filter[features][0]' => 'sms',
                     'filter[features][1]' => 'mms',
                     'filter[limit]' => 1,
                     'filter[best_effort]' => false },
            headers: request_headers)
      .to_return(status: 200, body: { data: }.to_json, headers: { content_type: 'application/json' })
  end

  def stub_number_orders(number)
    stub_request(:post, 'https://api.telnyx.com/v2/number_orders')
      .with(
        body: { phone_numbers: [{ phone_number: number }] },
        headers: request_headers
      ).to_return(status: 200, body: '')
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
