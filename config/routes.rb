Rails.application.routes.draw do
  devise_for :users
  post 'auth_user' => 'authentication#authenticate_user'

  namespace :api do
    namespace :v1 do
      get 'accounts', to: 'accounts#index' # ACCOUNT INDEX
      post 'accounts', to: 'accounts#create' # ACCOUNT CREATE
      get 'accounts/:account_number', to: 'accounts#show' # (HOME PAGE FOR DASHBOARD) ACCOUNTS SHOW
      patch 'accounts/:account_number', to: 'accounts#update'# ACCOUNT UPDATE
      delete 'accounts/:account_number', to: 'accounts#destroy' # ACCOUNT DESTROY

      get 'accounts/:account_number/bills', to: 'bills#index' #billing history
      get 'accounts/:account_number/bills/:id', to: 'bills#show' # BILLS SHOW
      get 'accounts/:account_number/bills/:start_date', to: 'bills#monthly_bill' #BILLS SHOW BY MONTH
      get 'accounts/:account_number/bills/unpaid', to: 'bills#unpaid_bills'
      patch 'accounts/:account_number/bills/:id/pay', to: 'bills#update' # kind of similar to UPDATE


      scope '/admin', module: 'admin' do
        resources :bills
        resources :users
        get '/users/:email', to: 'users#email', constraints: { email: /.+@.+/} # Look up by user email
        #more info on constraints: https://guides.rubyonrails.org/routing.html#advanced-constraints
        get '/stats/monthly_average_usage/:month/:year', to: 'stats#monthly_average_usage'
        get '/stats/user_activity', to: 'stats#user_activity'
      end
    end
  end

end
