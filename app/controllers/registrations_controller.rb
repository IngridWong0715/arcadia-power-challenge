class RegistrationsController < Devise::RegistrationsController
  skip_before_action :authenticate_request!
  before_action :configure_permitted_parameters if :devise_controller?

  	def create
  		build_resource(sign_up_params)
  		resource.save

  		if resource.persisted?
        binding.pry
        payload = payload(resource)
        render json: {message: "signed up with #{resource}", payload: payload}

  		else
  		  clean_up_passwords resource
  		  set_minimum_password_length

        render json: {error: "Unable to sign up user: #{resource.errors.full_messages}"}
  		end
  	end

  	protected
  	def configure_permitted_parameters
  		devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name])
  		devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name])
  	end

  	def response_to_sign_up_failure(resource)
  		if resource.email == "" && resource.password == nil
  			redirect_to root_path, alert: "Please fill out the form"
  		elsif User.pluck(:email).include? resource.email
  			redirect_to root_path, alert: "email already exists"
  		end
  	end

    def payload(user)
      return nil unless user and user.id
      {
        auth_token: JsonWebToken.encode({user_id: user.id}),
        user: {id: user.id, email: user.email}
      }
    end



end
