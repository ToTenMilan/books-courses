AppComponent::Engine.routes.draw do
  resources :games
  resources :teams
  resources :predictions, only: [:new, :create]
  root to: "welcome#index"
end
