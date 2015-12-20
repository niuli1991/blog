Rails.application.routes.draw do
  devise_for :admins
  root to: 'visitors#index'
  devise_for :users
  resources :users
  resources :blogs

  post 'upload' => 'upload#image'
end
