Rails.application.routes.draw do

  devise_for :users,
    # Added for facebook omniauth authentication
    controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  root to: 'pages#home'
  resources :treatments, only: [:index, :show]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

end
