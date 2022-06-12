# frozen_string_literal: true

require 'test_helper'

class GatewayAdapterTest < ActiveSupport::TestCase
  class ProvisionPhoneNumberTest < GatewayAdapterTest
    test 'requests available numbers' do
      area_code = "850"
      stub = stub_available_phone_numbers(area_code)

      result = GatewayAdapter.provision_phone_number(area_code)

      assert_requested stub
    end
  end

  def stub_available_phone_numbers(area_code)
    url = 'https://api.telnyx.com/v2/available_phone_numbers'

    stub_request(:get, url)
      .with(
        query: {
          filter: {
            country_code: 'US',
            best_effort: false,
            features: %w[sms mms],
            limit: 1,
            phone_number: {
             starts_with: area_code,
            },
          }
        },
        headers: {
          'Accept' => 'application/json',
          'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'Authorization' => /Bearer/,
          'Content-Type' => 'application/json',
          'User-Agent' => 'Faraday v2.3.0'
        }
      ).to_return(status: 200, body: '', headers: {})
  end
end
