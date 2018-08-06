Rails.application.routes.draw do
  devise_for :users

  get '/stats', to: 'accounts#stats'
  resources :accounts do
    resources :bills
    get '/bills/unpaid', to: 'bills#unpaid'
    get '/bills/paid', to: 'bills#paid'
    patch '/bills/:id/pay', to: 'bills#pay' # very similar to UPDATE! ASK
    get '/bills/:period', to: 'bills#by_period'

  end


  get '/users/:email', to: 'users#email', constraints: { email: /.+@.+/} # Look up by user email
    #more info on constraints: https://guides.rubyonrails.org/routing.html#advanced-constraints
  resources :users


  post 'auth_user' => 'authentication#authenticate_user'




  scope '/admin', module: 'admin' do

  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
