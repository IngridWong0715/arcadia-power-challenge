Rails.application.routes.draw do
  devise_for :users

  get '/stats', to: 'accounts#stats'

  resources :accounts do
    resources :bills
    get '/bills/unpaid', to: 'bills#get_unpaid_bills'
    get '/bills/paid', to: 'bills#get_paid_bills'
    patch '/bills/:id/pay', to: 'bills#pay_bill' # very similar to UPDATE! ASK
    get '/bills/:start_date', to: 'bills#get_bills_by_start_month'

  end

  post 'auth_user' => 'authentication#authenticate_user'

  scope '/admin', module: 'admin' do
    resources :users
    get '/users/:email', to: 'users#email', constraints: { email: /.+@.+/} # Look up by user email
    #more info on constraints: https://guides.rubyonrails.org/routing.html#advanced-constraints
    get '/stats/monthly_average_usage/:month/:year', to: 'stats#monthly_average_usage'
    get '/stats/user_activity', to: 'stats#user_activity'
  end

end
