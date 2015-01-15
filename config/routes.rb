Rails.application.routes.draw do

  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  root 'welcome#index'

  resources :users

end
