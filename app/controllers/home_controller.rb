class HomeController < ApplicationController
  before_action :authenticate_request!

    def index
      binding.pry
      render json: {'logged_in' => true}
    end
end
