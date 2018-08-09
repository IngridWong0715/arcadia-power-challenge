module Api
  module V1
    class AccountsController < ApplicationController
      before_action :set_account, except: [:all_customer_accounts, :create_new_account]
      rescue_from ::ActiveRecord::RecordNotFound, with: :record_not_found

      def index
        @accounts = current_user.accounts
        render json: @accounts
      end

      def show
        twelve_month_averages = Bill.twelve_month_averages
        customer_bills = prev_twelve_bills_usage(@account)
        comparison = {}
        render json: {aggregate: twelve_month_averages, customer: customer_bills, account_information: @account}
      end

      def create
        @account = current_user.accounts.new(account_params)

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
        @account = current_user.accounts.find_by_account_number(params[:account_number])
      end

      def record_not_found
        render json: { errors: ['Unable to find the requested data'] }, status: :not_found
      end

      def account_params
        params.require(:account).permit(:utility, :category, :account_number, :user_id)
      end

      def prev_twelve_bills_usage(account)
        bills = {}
        for i in 0..12 do
          month = (Date.today - i.month).month
          year = (Date.today - i.month).year
          month_year = (Date.today - i.month).strftime("%B %Y")
          bill = account.bills.by_month(month, year).first
          bills[month_year] = bill == nil ? nil : bill.usage
        end
        bills
      end
    end
  end
end
