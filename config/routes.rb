Rails.application.routes.draw do
  #temporary fix - change request later
  devise_scope :user do
   get '/users/sign_out' => 'devise/sessions#destroy'
 end
  devise_for :users
  root 'items#index'
  resources :items
end
