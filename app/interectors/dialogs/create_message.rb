# frozen_string_literal: true

module Dialogs
  class CreateMessage
    include Interactor

    def call
      message = Message.create(
        content: context.params[:content],
        read: true,
        dialog: context.dialog,
        direction: :outbound,
        kind: :sms
      )

      context.fail!(errors: message.errors) unless message.valid?
    end
  end
end
