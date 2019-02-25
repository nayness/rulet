Rails.application.routes.draw do
  resources :players
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'rounds#table'
  get '/table', to: 'rounds#table'
  post '/gamble', to: 'rounds#gamble'
  get '/infinite_rounds', to: 'rounds#infinite_rounds'
  post '/add_players', to: 'players#add_players'
  get '/add_players', to: 'players#add_players'
  get '/last_round', to: 'rounds#last_round'
  post '/new_round', to: 'rounds#create'
  post '/round_winners', to: 'rounds#winners'
end
