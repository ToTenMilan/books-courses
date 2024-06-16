# require 'sidekiq/web'

Rails.application.routes.draw do
  resources :orders, only: [ :new, :create, :show ]
  resources :simulated_behaviors, only: [ :edit, :update ]
  root "welcome#show"
  # mount Sidekiq::Web => "/sidekiq"
end
