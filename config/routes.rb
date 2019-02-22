Rails.application.routes.draw do
  resources :players
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'rounds#table'
  get '/table', to: 'rounds#table'
  post '/gamble/:round_id', to: 'rounds#create'
  get '/infinite_rounds/:round_id', to: 'rounds#infinite_rounds'
  get '/add_players/:round_id', to: 'players#add_players'
end
