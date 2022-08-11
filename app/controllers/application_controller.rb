# frozen_string_literal: true

class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken

  def validate_admin_user
    render json: { error: 'Not enough permissions' }, status: :unauthorized unless current_user&.admin
  end
end
