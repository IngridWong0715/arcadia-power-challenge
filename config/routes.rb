Rails.application.routes.draw do
  devise_for :users, :controllers => {:registrations => "registrations"}
  post 'auth_user' => 'authentication#authenticate_user'

  namespace :api do
    namespace :v1 do
      get 'accounts', to: 'accounts#index'
      post 'accounts', to: 'accounts#create'
      get 'accounts/:account_number', to: 'accounts#show'
      patch 'accounts/:account_number', to: 'accounts#update'
      delete 'accounts/:account_number', to: 'accounts#destroy'

      get 'accounts/:account_number/bills', to: 'bills#index'
      get 'accounts/:account_number/bills/unpaid', to: 'bills#unpaid_bills'
      get 'accounts/:account_number/bills/:start_date', to: 'bills#show_by_month'
      patch 'accounts/:account_number/bills/:start_date/pay', to: 'bills#pay_by_month'

      scope '/admin', module: 'admin' do

        resources :accounts
        resources :bills

        resources :users
        get '/users/by_email/:email', to: 'users#show_by_email', constraints: { email: /.+@.+/}
        get '/stats/monthly_average_usage/:month/:year', to: 'stats#monthly_average_usage'
        get '/stats/user_activity', to: 'stats#user_activity_breakdown'
        get 'stats/account_breakdown', to: 'stats#account_type_breakdown'
      end
    end
  end

end
