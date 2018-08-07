class BillsController < ApplicationController
  before_action :set_bill, only: [:show, :update, :destroy, :pay]
  rescue_from ::ActiveRecord::RecordNotFound, with: :record_not_found

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

  def pay_bill
    if @bill.update(status: "paid")
      render json: @bill
    else
      render json: @bill.errors, status: :unprocessable_entity
    end
  end

  def get_bill_by_start_month
    @bill = current_account.bills.find_by_start_date(params[:start_date])
    render json: @bill
  end

  def stats_comparison_to_average
    #show last 12 months' bills as compared to AP's average
    

  end


  def get_unpaid_bills
    @unpaid_bills = current_account.bills.unpaid
    render json: @bills
  end

  def get_paid_bills
    @paid_bills = current_account.bills.unpaid
    render json: @bills
  end


  private
    def current_account
      Account.find(params[:account_id])
    end

    def set_bill
      @bill = current_account.bills.find(params[:id])
    end

    def record_not_found
      render json: {"Access Prohibited": "You don't have access to this bill"}
    end

    # Only allow a trusted parameter "white list" through.
    def bill_params
      params.require(:bill).permit(:start_date, :end_date, :usage, :charges, :status, :account_id)
    end
end
