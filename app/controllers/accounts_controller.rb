class AccountsController < ApplicationController
  before_action :set_account, only: [:show, :update, :destroy]
  rescue_from ::ActiveRecord::RecordNotFound, with: :record_not_found

  # GET /accounts
  def index
    @accounts = @current_user.accounts.all

    render json: @accounts
  end

  # GET /accounts/1
  def show
    render json: @account
  end

  # POST /accounts
  def create
    @account = @current_user.new(account_params)

    if @account.save
      render json: @account, status: :created, location: @account
    else
      render json: @account.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /accounts/1
  def update
    if @account.update(account_params)
      render json: @account
    else
      render json: @account.errors, status: :unprocessable_entity
    end
  end

  # DELETE /accounts/1
  def destroy
    @account.destroy
  end


  def stats
  end

  private

    def set_account
      @account = @current_user.accounts.find(params[:id])
    end

    def record_not_found
      render json: {"Access Prohibited": "You don't have access to this account"}
    end

    # Only allow a trusted parameter "white list" through.
    def account_params
      params.require(:account).permit(:utility, :type, :account_number, :user_id)
    end
end
