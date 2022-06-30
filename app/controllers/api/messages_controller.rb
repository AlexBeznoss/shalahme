# frozen_string_literal: true

module Api
  class MessagesController < Api::ApplicationController
    before_action :require_signin
    before_action :find_message

    def read
      authorize! @message

      Messages::Read.call(message: @message, current_user:)

      head :ok
    end

    private

    def find_message
      @message = Message.find(params[:id])
    end
  end
end
