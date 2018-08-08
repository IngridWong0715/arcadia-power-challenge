Rails.application.routes.draw do
  devise_for :users


  get 'accounts', to: 'customer_account#all_customer_accounts' # ACCOUNT INDEX
  post 'accounts', to: 'customer_account#create_new_account' # ACCOUNT CREATE
  get 'accounts/:account_number', to: 'customer_account#home' # ACCOUNTS SHOW
  patch 'accounts/:account_number', to: 'customer_account#update_account_info'# ACCOUNT UPDATE
  delete 'accounts/:account_number', to: 'customer_account#delete_account' # ACCOUNT DESTROY


  get 'accounts/:account_number/bills', to: 'customer_account#billing_history' #BILLS INDEX
  get 'accounts/:account_number/bills/:bill_id', to: 'customer_account#show_bill' # BILLS SHOW
  get 'accounts/:account_number/bills/:start_date', to: 'customer_account#monthly_bill' #BILLS SHOW BY MONTH
  get 'accounts/:account_number/bills/unpaid', to: 'customer_account#unpaid_bills'
  patch 'accounts/:account_number/bills/:bill_id/pay', to: 'customer_account#pay_bill' # kind of similar to UPDATE



  post 'auth_user' => 'authentication#authenticate_user'

  scope '/admin', module: 'admin' do
    resources :accounts
    resources :bills
    resources :users
    get '/users/:email', to: 'users#email', constraints: { email: /.+@.+/} # Look up by user email
    #more info on constraints: https://guides.rubyonrails.org/routing.html#advanced-constraints
    get '/stats/monthly_average_usage/:month/:year', to: 'stats#monthly_average_usage'
    get '/stats/user_activity', to: 'stats#user_activity'
  end

end
