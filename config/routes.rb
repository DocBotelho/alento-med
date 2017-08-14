Rails.application.routes.draw do
  get 'treatments/index'

  get 'treatments/show'

  devise_for :users
  root to: 'pages#home'
  resources :treatments, only: [:index, :show]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
