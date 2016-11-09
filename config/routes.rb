Rails.application.routes.draw do
  devise_for :users
  root "welcome#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users
  resources :mechanics

  resources :specials
  
  get '/cars/:car_id/history', to: "users#index"

  resources :cars do
    resources :maintenances
    resources :issues do
      resources :repairs
    end
  end
end
