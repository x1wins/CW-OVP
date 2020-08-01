require 'sidekiq/web'

Rails.application.routes.draw do
  devise_for :users
  resources :encodes, :except => [:edit, :update]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root :to => "encodes#index"
  authenticate :user do
    mount Sidekiq::Web => '/sidekiq'
  end
  default_url_options :host => "localhost:3000"
end

