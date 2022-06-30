# frozen_string_literal: true

module Messages
  class Read
    include Interactor

    def call
      return if context.message.read?

      context.message.update!(read: true)

      broadcast_counter_for(:show)
      broadcast_counter_for(:index)
    end

    private

    def broadcast_counter_for(type)
      context.message.dialog.broadcast_replace_later_to(
        channel_for(type),
        partial: 'dialogs/read_counter',
        target: target_for(type),
        locals: { type: }
      )
    end

    def channel_for(type)
      case type
      when :index
        [context.current_user, 'dialogs']
      when :show
        [context.message.dialog, 'convo']
      end
    end

    def target_for(type)
      dialog = context.message.dialog

      "dialog_#{dialog.id}_read_counter_#{type}"
    end
  end
end
