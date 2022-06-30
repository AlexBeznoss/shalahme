# frozen_string_literal: true

class ConvosController < ApplicationController
  before_action :require_signin
  before_action :redirect_to_current_dialog, only: %i[index]

  def index; end

  def show
    @dialog =
      Dialog
      .joins(:user_phone_number)
      .where(user_phone_numbers: { status: :ready, user_id: current_user.id })
      .find(params[:id])
    session['current_dialog'] = @dialog.id

    render :index
  end

  private

  def redirect_to_current_dialog
    return if params[:start_for]

    redirect_to convo_path(current_dialog) if current_dialog
  end

  def current_dialog
    return unless current_dialog_id

    @current_dialog ||= Dialog
                        .joins(:user_phone_number)
                        .where(user_phone_numbers: { status: :ready, user_id: current_user.id })
                        .find(current_dialog_id)
  rescue ActiveRecord::RecordNotFound
    session['current_dialog'] = nil
  end

  def current_dialog_id
    session['current_dialog']
  end
end
