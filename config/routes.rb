require 'sidekiq/web'

Rails.application.routes.draw do
  get 'users/index'
  resources :webhooks
  devise_for :users
  resources :encodes, :except => [:edit, :update, :delete]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root :to => "encodes#index"
  authenticate :user do
    mount Sidekiq::Web => '/sidekiq'
  end
end

