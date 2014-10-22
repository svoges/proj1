Rails.application.routes.draw do
  root to: 'home#index'
  devise_for :trainers
  resources :trainers
  patch '/capture', to:'pokemons#capture'
  patch '/damage', to:'pokemons#damage'
  patch '/heal', to:'pokemons#heal'
  get '/pokemons/new', to:'pokemons#new'
  post '/pokemons/create', to:'pokemons#create'
end
