class AdminController < ApplicationController
  before_action :authorize_admin_request!

  private

  def authorize_admin_request!
    unless is_admin?
      render json: { errors: ['Unauthorized Access: Must Be An Admin'] }, status: :forbidden
    end
  end

  def is_admin?
    current_user.admin
  end
end
