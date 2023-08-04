# frozen_string_literal: true

module Api
  module Webhooks
    class TelnyxController < ApplicationController
      def create
        head :ok
      end
    end
  end
end
