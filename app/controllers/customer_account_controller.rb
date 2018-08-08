class CustomerAccountController < ApplicationController
  before_action :set_account, except: [:all_customer_accounts, :create_new_account]
  rescue_from ::ActiveRecord::RecordNotFound, with: :record_not_found


  def all_customer_accounts
    accounts = current_user.accounts
    render json: accounts
  end

  def create_new_account
    binding.pry
    #WORK ON VALIDATION: a new account should only be created if it's unique for the user
    # (utility + account_number) combo must be unique
    @account = current_user.accounts.new(account_params)

    if @account.save
      render json: @account, status: :created, location: @account
    else
      render json: @account.errors, status: :unprocessable_entity
    end
  end
  def home
      #home page
      # displays stats
      # Monthly average:

    twelve_month_averages = Bill.twelve_month_averages
    customer_bills = prev_twelve_bills_usage(@account)

    comparison = {}

    render json: {aggregate: twelve_month_averages, customer: customer_bills, account_information: @account}


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
    # FOR FUTURE IMPLEMENTATION: SPLIT ANALYSIS INTO COMMERCIAL VS RESIDENTIAL
    # def has_two_accounts
    #   current_user.accounts.count == 2
    # end
    #
    # def residential_account
    #   current_user.accounts.find_by_category("residential")
    # end
    #
    # def commercial_account
    #   current_user.accounts.find_by_category("commercial")
    # end

    def set_account
      @account = current_user.accounts.find_by_account_number(params[:account_number])
    end

    def record_not_found
      render json: {"Access Prohibited": "You don't have access to this bill"}
    end

    def customer_params
      params.permit(:account_number)
    end

    def account_params
      params.require(:account).permit(:utility, :type, :account_number, :user_id)
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
