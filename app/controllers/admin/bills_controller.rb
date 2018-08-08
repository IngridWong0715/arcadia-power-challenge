class Admin::BillsController < ApplicationController
  before_action :set_bill, only: [:show, :update, :destroy]
  rescue_from ::ActiveRecord::RecordNotFound, with: :record_not_found

  # GET /bills
  def index
    @bills = Bill.all
    render json: @bills
  end

  # GET /bills/1
  def show
    render json: @bill
  end

  # POST /bills THIS DOESN"T MAKE SENSE!! DELETE
  def create
    @bill = Bill.new(bill_params)

    if @bill.save
      render json: @bill, status: :created, location: @bill
    else
      render json: @bill.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /bills/1 # A CUSTOMER SHOULDN"T BE ABLE TO UPDATE A BILL
  def update
    if @bill.update(bill_params)
      render json: @bill
    else
      render json: @bill.errors, status: :unprocessable_entity
    end
  end

  # DELETE /bills/1 # A CUSTOMER SHOULDN"T BE ABLE TO UPDATE A BILL
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
