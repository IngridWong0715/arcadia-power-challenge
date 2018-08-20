module Api
  module V1
    class Admin::AccountsController < AdminController
      before_action :set_account, only: [:show, :update, :destroy]

      def index
        @accounts = Account.all
        render json: @accounts
      end

      def show
        render json: @account
      end

      def create
        @account = Account.find_or_initialize_by(account_params)

        if @account.new_record?
          if @account.save
            render json: @account, status: :created, location: @account
          else
            render json: @account.errors, status: :unprocessable_entity
          end
        else
          render json: {errors: "account already exists", account: @account}, location: @account
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

        def account_params
          params.require(:account).permit(:utility, :category, :account_number, :user_id)
        end

        def account_url(account)
          "localhost:3000/api/v1/accounts/#{account.account_number}"
        end

    end
  end
end
