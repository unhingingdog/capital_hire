Rails.application.routes.draw do
  #temporary fix - change request later
  devise_scope :user do
   get '/users/sign_out' => 'devise/sessions#destroy'
 end
  devise_for :users
  root 'items#home'
  get '/items/hire', to: 'items#hire'
  get '/items/search_results', to: 'items#search_results'
  resources :items do
    resources :orders
  end
end
