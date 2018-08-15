Rails.application.routes.draw do

  root 'home#landing'
  get '/find' => 'home#index'
  get '/search/:search' => "home#search"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
