# frozen_string_literal: true

module MessagesHelper
  def message_content_tag(message)
    if message.read?
      tag.div(message.content)
    else
      tag.div(
        message.content,
        data: { controller: 'track-message-read', 'track-message-read-id-value': message.id }
      )
    end
  end
end
