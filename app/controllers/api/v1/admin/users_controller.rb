module Api
  module V1
    class Admin::UsersController < AdminController
      before_action :set_user, only: [:show, :update, :destroy]

      def index
        @users = User.all

        render json: @users
      end

      def show
        render json: @user
      end

      def create
        @user = User.new(user_params)

        if @user.save
          render json: @user, status: :created
        else
          render json: @user.errors, status: :unprocessable_entity
        end
      end

      def update
        if @user.update(user_params)
          render json: @user
        else
          render json: @user.errors, status: :unprocessable_entity
        end
      end

      def destroy
        @user.destroy
      end

      def show_by_email
        @user = User.find_by_email! params[:email]
        render json: @user
      end

      private

      def set_user
        @user = User.find(params[:id])
      end

      def user_params
        params.require(:user).permit(:first_name, :last_name, :email, :status, :password, :password_confirmation)
      end
    end
  end
end
