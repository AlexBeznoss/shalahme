# frozen_string_literal: true

class DialogsController < ApplicationController
  before_action :require_signin

  def index
    dialogs_query =
      Dialog
      .joins(:user_phone_number)
      .where(user_phone_numbers: { status: :ready, user_id: current_user.id })
      .where.not(id: params[:except])
      .includes(:recipient_phone_number, :user_phone_number)
      .order(updated_at: :desc)

    @pagy, @dialogs = pagy(dialogs_query)
  end

  def new
    args = { user: current_user }
    args[:user_number_id] = params[:start_for] if params[:start_for]
    @dialog = NewDialog.new(args)
  end

  def create
    @form = Dialogs::StartDialog.call(user: current_user, params: dialog_params)

    if @form.success?
      respond_to do |f|
        f.turbo_stream
        f.html { redirect_to convo_path(@form.dialog) }
      end
    else
      @dialog = NewDialog.new(dialog_params.merge(user: current_user, errors: @form.errors))
      render :new
    end
  end

  private

  def find_phone
    @phone = current_user.phone_numbers.ready.find(params[:phone_id])
  end

  def dialog_params
    params.require(:dialog).permit(:user_number_id, :recipient_number, :content)
  end
end
