Rails.application.routes.draw do

  root 'home#landing'
  get '/find' => 'home#index'
  get '/search-around/:search' => "home#search_around"
  get '/search-center/:search' => "home#search_center"
  get '/hot/:id' => "home#hot"
  post '/rating' => "home#rating"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
