Rails.application.routes.draw do
  resources :bills
  resources :accounts
    get '/users/:email', to: 'users#email', constraints: { email: /.+@.+/} # Look up by user email
    #more info on constraints: https://guides.rubyonrails.org/routing.html#advanced-constraints
  resources :users

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
