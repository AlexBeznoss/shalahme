# frozen_string_literal: true

module Api
  class ApplicationController < ActionController::API
    include ActionPolicy::Controller
    authorize :user, through: :current_user

    rescue_from 'ActiveRecord::RecordNotFound' do
      render json: {}, status: :not_found
    end

    rescue_from ActionPolicy::Unauthorized do |_|
      render json: {}, status: :unauthorized
    end

    private

    def require_signin
      return unless current_user.nil?

      render json: {}, status: :unauthorized
    end

    def current_user
      @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
    end
  end
end
