module Api
  module V1
    class BillsController < ApplicationController
      before_action :set_bill, only: [ :show_by_month, :pay_by_month ]
      before_action :set_account, only: [:index, :unpaid_bills ]
      rescue_from ::ActiveRecord::RecordNotFound, with: :record_not_found

      def index
        @bills = @account.bills.all
        render json: @bills
      end

      def unpaid_bills
        @unpaid_bills = @account.bills.unpaid
        render json: @unpaid_bills
      end

      def show_by_month
        render json: @bill
      end

      def pay_by_month
  
        if bill_params(:status)[:status] != "paid"
          render json: { errors: "You can only perform a 'pay' action on a bill" }
        elsif @bill.status == "paid"
          render json: { errors: "Bill has already been paid" }, status: :unprocessable_entity
        else
          if @bill.update(bill_params(:status))
            render json: @bill
          else
            render json: @bill.errors, status: :unprocessable_entity
          end
        end
      end

      private

      def set_account
        @account = account
      end

      def account
        account = Account.find_by_account_number(params[:account_number])
        unless account
          record_not_found
        end
        account
      end

      def set_bill
        month = params[:start_date].split('-')[1]
        year = params[:start_date].split('-')[0]
        @bill = account.bills.by_month(month, year).first

        unless @bill
          record_not_found
        end
      end

      def record_not_found
        render json: { errors: "Unable to find the requested data" }, status: :not_found
      end

      def bill_params(*args)
        params.require(:bill).permit(*args)
      end
    end
  end
end
