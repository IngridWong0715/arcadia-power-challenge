module Api
  module V1
    class Admin::BillsController < AdminController
      before_action :set_bill, only: [:show, :update, :destroy]

      def index
        @bills = Bill.all
        render json: @bills, status: 200
      end

      def show
        render json: @bill
      end

      def create
        @bill = Bill.find_or_initialize_by(bill_params)

        if @bill.new_record?
          if @bill.save
            render json: @bill, status: :created, location: @bill
          else
            render json: @bill.errors, status: :unprocessable_entity
          end
        else
          render json: {errors: "bill already exists", bill: @bill}, location: @bill
        end
      end

      def update
        if @bill.update(bill_params)
          render json: @bill
        else
          render json: @bill.errors, status: :unprocessable_entity
        end
      end

      def destroy
        @bill.destroy
      end

      private

      def set_bill
        @bill = Bill.find(params[:id])
      end

      def bill_params
        params.require(:bill).permit(:start_date, :end_date, :usage, :charges, :status, :account_id)
      end

      def bill_url(bill)
        "localhost:3000/api/v1/accounts/#{bill.account.account_number}/bills/#{bill.id}"
      end
    end
  end
end
