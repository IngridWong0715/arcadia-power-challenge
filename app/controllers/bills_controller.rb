class BillsController < ApplicationController
  before_action :set_bill, only: [:show, :update, :destroy, :pay]

  # GET /bills
  def index
    @bills = @current_user.bills
    render json: @bills
  end

  # GET /bills/1
  def show
    render json: @bill
  end

  # POST /bills THIS DOESN"T MAKE SENSE!! DELETE
  def create
    @bill = @current_user.new(bill_params)

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

  def pay
    if @bill.update(status: "paid")
      render json: @bill
    else
      render json: @bill.errors, status: :unprocessable_entity
    end
  end

  def by_period
    @bills = @current_user.bills.find_by_start_date(params[:period])
    render json: @bills
  end

  def unpaid
    @bills = @current_user.bills.unpaid
    render json: @bills
  end

  def paid
    @bills = @current_user.bills.unpaid
    render json: @bills
  end

  def stats
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bill
      @bill = @current_user.bills.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def bill_params
      params.require(:bill).permit(:start_date, :end_date, :usage, :charges, :status, :account_id, :period)
    end
end
