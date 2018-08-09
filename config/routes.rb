Rails.application.routes.draw do
  devise_for :users
  post 'auth_user' => 'authentication#authenticate_user'

  namespace :api do
    namespace :v1 do
      get 'accounts', to: 'accounts#index'
      post 'accounts', to: 'accounts#create'
      get 'accounts/:account_number', to: 'accounts#show'
      patch 'accounts/:account_number', to: 'accounts#update'
      delete 'accounts/:account_number', to: 'accounts#destroy'

      get 'accounts/:account_number/bills', to: 'bills#index'
      get 'accounts/:account_number/bills/:id', to: 'bills#show'
      get 'accounts/:account_number/bills/:start_date', to: 'bills#monthly_bill'
      get 'accounts/:account_number/bills/unpaid', to: 'bills#unpaid_bills'
      patch 'accounts/:account_number/bills/:id/pay', to: 'bills#update'

      scope '/admin', module: 'admin' do
        resources :bills
        resources :accounts
        resources :users
        get '/users/:email', to: 'users#email', constraints: { email: /.+@.+/}
        get '/stats/monthly_average_usage/:month/:year', to: 'stats#monthly_average_usage'
        get '/stats/user_activity', to: 'stats#user_activity'
        get 'stats/account_breakdown', to: 'stats#account_type_breakdown'
      end
    end
  end

end
