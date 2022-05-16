# frozen_string_literal: true

require 'test_helper'
require 'capybara/cuprite'

Capybara.register_driver(:cuprite_desktop) do |app|
  Capybara::Cuprite::Driver.new(app, window_size: [1400, 1400], headless: false)
end

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  driven_by :cuprite, screen_size: [1400, 1400]
end
