Rails.application.routes.draw do
  devise_for :users

  get '/home', to: 'customer#home'

  get 'accounts/:account_number', to: 'customer#account_information'
  get 'accounts/:account_number/billing_history', to: 'customer#billing_history'

  get 'accounts/:account_number/bills/unpaid', to: 'customer#unpaid_bills'
  patch 'accounts/:account_number/bills/:bill_id/pay', to: 'customer#pay_bill'
  get 'accounts/:account_number/bills/:start_date', to: 'customer#monthly_bill'


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
