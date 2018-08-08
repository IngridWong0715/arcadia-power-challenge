class CustomerController < ApplicationController
  before_action :set_account, only: [:account_information, :billing_history, :unpaid_bills, :pay_bill, :monthly_bill ]
  rescue_from ::ActiveRecord::RecordNotFound, with: :record_not_found

  def home

    if has_two_accounts

    else

    end
    residential_twelve_month_averages = Bill.twelve_month_averages
    customer_bills = prev_twelve_bills_usage(residential_account)
    binding.pry
    comparison = {}

    render json: twelve_month_averages

    #home page
    # displays stats
    # Monthly average:


  end
  #Controller for the authenticated user's accounts
  # One user can have two accounts: residential & commercial
  def account_information
    #get account information based on account_number
    render json: @account
  end

  def billing_history
    @bills = @account.bills
    render json: @bills
  end

  def unpaid_bills
    @unpaid_bills = @account.bills.unpaid
    render json: @bills
  end

  def monthly_bill

    month = params[:start_date].split('-')[1]
    year = params[:start_date].split('-')[0]
    @bill = @account.bills.by_month(month, year)
    render json: @bill
  end

  def pay_bill #bill_id or start_date?
    @bill = @account.bills.find(params[:bill_id])
    if @bill.update(status: "paid")
      render json: @bill
    else
      render json: @bill.errors, status: :unprocessable_entity
    end
  end

  private

    def has_two_accounts
      current_user.accounts.count == 2
    end

    def residential_account
      current_user.accounts.find_by_category("residential")
    end

    def commercial_account
      current_user.accounts.find_by_category("commercial")
    end

    def set_account
      @account = current_user.accounts.find_by_account_number(params[:account_number])
    end

    def record_not_found
      render json: {"Access Prohibited": "You don't have access to this bill"}
    end

    def customer_params
      params.permit(:account_number)
    end

    def prev_twelve_bills_usage_by_account_type(account)
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

    def


end
