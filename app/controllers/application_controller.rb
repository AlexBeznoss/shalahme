# frozen_string_literal: true

class ApplicationController < ActionController::Base
  private

  def require_signin
    return if signed_in?

    flash[:warning] = t('login_warning')
    redirect_to root_path
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  helper_method :current_user

  def signed_in?
    !current_user.nil?
  end

  helper_method :signed_in?

  def current_user?(user)
    current_user == user
  end

  helper_method :current_user?
end
