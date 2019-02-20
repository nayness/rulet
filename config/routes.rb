Rails.application.routes.draw do
  resources :players
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'rounds#table'
  get '/gamble', to: 'rounds#table'
  post '/gamble', to: 'rounds#create'
end
