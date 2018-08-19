module Api
  module V1
    class Admin::AccountsController < AdminController
      before_action :set_account, only: [:show, :update, :destroy]
      rescue_from ::ActiveRecord::RecordNotFound, with: :record_not_found

      def index
        @accounts = Account.all
        render json: @accounts
      end

      def show
        render json: @account
      end

      def create
        @account = Account.new(account_params)

        if @account.save
          render json: @account, status: :created, location: @account
        else
          render json: @account.errors, status: :unprocessable_entity
        end
      end

      def update
        if @account.update(account_params)
          render json: @account
        else
          render json: @account.errors, status: :unprocessable_entity
        end
      end

      def destroy
        @account.destroy
      end

      private

        def set_account
          @account = Account.find(params[:id])
        end

        def record_not_found
          render json: {"Access Prohibited": "You don't have access to this account"}
        end

        def account_params
          params.require(:account).permit(:utility, :category, :account_number, :user_id)
        end
    end
  end
end
