# SIGN IN CONTROLLER

class AuthenticationController < ApplicationController
  skip_before_action :authenticate_request!
#  before_action :configure_permitted_parameters if :devise_controller?
  def authenticate_user
    binding.pry
    user = User.find_for_database_authentication(user_params(:email))
    if user.valid_password?(user_params(:password)["password"])
      render json: payload(user)
    else
      render json: {errors: ['Invalid Username/Password']}, status: :unauthorized
    end
  end

  private

  def payload(user)
    return nil unless user and user.id
    {
      auth_token: JsonWebToken.encode({user_id: user.id}),
      user: {id: user.id, email: user.email}
    }
  end

  # def sign_in_email_params
  #   params.require(:user).permit(:email,:password)
  # end
  #
  # def sign_in_password_params
  #   params.require(:user).permit(:password)
  # end

  def user_params(*args)
    params.require(:user).permit(*args)
  end



  # def configure_permitted_parameters
  #   binding.pry
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:email])
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name])
  # end

  #
  # def resource_name
  #   :user
  # end
  #
  # def resource
  #   @resource ||= User.new
  # end
  #
  # def resource_class
  #   User
  # end
end
