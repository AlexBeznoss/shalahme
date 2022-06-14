# frozen_string_literal: true

module Api
  class MessagesController < Api::ApplicationController
    before_action :require_signin
    before_action :find_message

    def read
      authorize! @message

      @message.update!(read: true)

      @message.dialog.then do |d|
        d.broadcast_replace_later_to(
          [d, 'convo'],
          **broadcast_params(d)
        )
      end

      head :ok
    end

    private

    def find_message
      @message = Message.find(params[:id])
    end

    def broadcast_params(dialog)
      {
        partial: 'dialogs/read_counter',
        target: "dialog_#{dialog.id}_read_counter",
        locals: { element_class: 'read_counter--show' }
      }
    end
  end
end
