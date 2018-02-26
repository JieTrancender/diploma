Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api do
  	namespace :v1 do
  		resources :users, only: %i[index create show update destroy]
  		resources :sessions, only: %i[create]

  		scope path: '/user/:user_id' do
  			resources :microposts, only: %i[index]
  		end
  	end
  end
end
