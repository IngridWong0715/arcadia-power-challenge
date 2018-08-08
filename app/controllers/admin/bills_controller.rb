class Admin::BillsController < ApplicationController
  before_action :set_bill, only: [:show, :update, :destroy]
  rescue_from ::ActiveRecord::RecordNotFound, with: :record_not_found

  def index
    @bills = Bill.all
    render json: @bills
  end

  def show
    render json: @bill
  end

  def create
    @bill = Bill.new(bill_params)

    if @bill.save
      render json: @bill, status: :created, location: @bill
    else
      render json: @bill.errors, status: :unprocessable_entity
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

    def record_not_found
      render json: {"Access Prohibited": "You don't have access to this bill"}
    end

    def bill_params
      params.require(:bill).permit(:start_date, :end_date, :usage, :charges, :status, :account_id)
    end
end
