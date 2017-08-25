Rails.application.routes.draw do
  devise_for :users,
    # Added for facebook omniauth authentication
    controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  require "sidekiq/web"
  authenticate :user, lambda { |u| u.admin } do
    mount Sidekiq::Web => '/sidekiq'
  end
  get 'sobrenos', to: 'pages#sobrenos'
  root to: 'pages#home'
  resources :treatments, only: [:create, :index]
  resources :institutions, only: [:index, :show]
end
