# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :require_signin
  before_action :find_user, only: %i[edit update]

  def index
    @users = User.all
  end

  def edit; end

  def update
    if @user.update(user_params)
      flash.now[:info] = 'User successfully updated!'

      respond_to do |f|
        f.turbo_stream
        f.html { redirect_to users_path }
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:role)
  end

  def find_user
    @user = User.find(params[:id])
  end
end
