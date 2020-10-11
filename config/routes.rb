Rails.application.routes.draw do
  root 'home#top'
  devise_for :users
  get 'target/list' => 'target#list'
  resources :target
  resources :day, only: [:create, :destroy]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
