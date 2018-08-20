module Api
  module V1
    class AccountsController < ApplicationController
      before_action :set_account, only: [:show, :update, :destroy]
      rescue_from ::ActiveRecord::RecordNotFound, with: :record_not_found

      def index
        @accounts = current_user.accounts
        render json: @accounts
      end

      def show
        twelve_month_averages = Bill.twelve_month_averages
        customer_bills = @account.prev_twelve_bills_usage
        comparison = {}
        render json: {account_information: @account,
                      stats: { account_monthly_usage: customer_bills,
                               aggregate_monthly_averages: twelve_month_averages}}
      end

      def create
        @account = current_user.accounts.find_or_initialize_by(account_params)

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
        render json: {message: "account successfully deleted"}
      end

      private

      def set_account
        @account = current_user.accounts.find_by_account_number(params[:account_number])
        unless @account
          record_not_found
        end
      end

      def account_url(account)
        "localhost:3000/api/v1/accounts/#{account.account_number}"
      end

      def record_not_found
        render json: { errors: "Unable to find the requested data" }, status: :not_found
      end

      def account_params
        params.require(:account).permit(:utility, :category, :account_number, :user_id)
      end

    end
  end
end
