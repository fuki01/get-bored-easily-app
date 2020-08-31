Rails.application.routes.draw do
  root 'home#top'
  devise_for :users
  resources :target
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
