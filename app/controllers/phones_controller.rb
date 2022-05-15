# frozen_string_literal: true

class PhonesController < ApplicationController
  before_action :require_signin
  before_action :find_phone, only: %i[edit update destroy]

  def index
    @phones = current_user.user_phone_numbers.kept
  end

  def new
    @phone = current_user.user_phone_numbers.build
  end

  def create
    @phone = current_user.user_phone_numbers.build(phone_params)

    if @phone.save
      flash.now[:success] = 'Phone created! It will be ready for usage soon.'

      respond_to do |f|
        f.turbo_stream
        f.html { redirect_to phones_path }
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @phone.update(update_phone_params)
      flash.now[:info] = 'Phone successfully updated!'

      respond_to do |f|
        f.turbo_stream
        f.html { redirect_to phones_path }
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @phone.discard!

    respond_to do |f|
      f.turbo_stream
      f.html { redirect_to phones_path }
    end
  end

  private

  def phone_params
    params.require(:user_phone_number).permit(:name, :area_code)
  end

  def update_phone_params
    params.require(:user_phone_number).permit(:name)
  end

  def find_phone
    @phone = current_user.user_phone_numbers.kept.find(params[:id])
  end
end
