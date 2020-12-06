Rails.application.routes.draw do
  root 'home#top'
  devise_for :users
  get 'user/:id' => "user#show", as: 'user_profile'
  get 'target/list' => 'target#list'
  get 'target/clear' => 'target#clear', as:'target_clear'
  resources :target
  resources :day, only: [:create, :destroy]
end
