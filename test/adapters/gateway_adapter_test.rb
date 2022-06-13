# frozen_string_literal: true

require 'test_helper'

class GatewayAdapterTest < ActiveSupport::TestCase
  class ProvisionPhoneNumberTest < GatewayAdapterTest
    test 'requests available numbers' do
      area_code = '850'
      number = '+18503608622'

      stub = stub_available_numbers(area_code, number)
      stub_number_orders(number)

      GatewayAdapter.provision_phone_number(area_code)

      assert_requested stub
    end

    test 'requests number order' do
      area_code = '850'
      number = '+18503608622'

      stub_available_numbers(area_code, number)
      stub = stub_number_orders(number)

      GatewayAdapter.provision_phone_number(area_code)

      assert_requested stub
    end
  end

  def stub_available_numbers(area_code, number)
    stub_request(:get, 'https://api.telnyx.com/v2/available_phone_numbers')
      .with(
        query: {
          filter: {
            country_code: 'US',
            best_effort: false,
            features: %w[sms mms],
            limit: 1,
            phone_number: { starts_with: area_code }
          }
        },
        headers: request_headers
      ).to_return(status: 200, body: { data: [{ phone_number: number }] }.to_json)
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
      'Accept' => 'application/json',
      'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
      'Authorization' => /Bearer/,
      'Content-Type' => 'application/json',
      'User-Agent' => 'Faraday v2.3.0'
    }
  end
end
