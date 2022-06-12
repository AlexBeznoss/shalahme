# frozen_string_literal: true

class MessagesController < ApplicationController
  before_action :require_signin
  before_action :find_dialog

  def index
    @pagy, @messages = pagy(@dialog.messages.order(created_at: :desc))
  end

  def new
    @message = @dialog.messages.new
  end

  def create
    @message = @dialog.messages.new(message_params.merge(default_values))

    if @message.save
      respond_to do |f|
        f.turbo_stream
        f.html { redirect_to convo_path(@dialog) }
      end
    else
      render :new
    end
  end

  private

  def find_dialog
    @dialog =
      Dialog
      .joins(:user_phone_number)
      .where(user_phone_number: { status: :ready, user_id: current_user.id })
      .find(params[:dialog_id])
  end

  def message_params
    params.require(:message).permit(:content)
  end

  def default_values
    { kind: :sms, read: true, direction: :outbound }
  end
end
