Rails.application.routes.draw do
  get 'point/show'
  root 'home#top'
  devise_for :users
  get 'users' => "user#index", as: 'user_list'
  get 'user/:id' => "user#show", as: 'user_profile'
  get 'target/list' => 'target#list'
  get 'target/clear' => 'target#clear', as:'target_clear'
  resources :target
  resources :relationships, only: [:create, :destroy]
  get 'follower_list/:id' => "relationships#follower", as: 'follower_list'
  get 'follow_list/:id' => "relationships#follow", as: 'follow_list'
  resources :day, only: [:create, :destroy]
end
