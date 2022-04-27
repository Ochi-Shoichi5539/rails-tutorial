Rails.application.routes.draw do
  get 'sessions/new'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  # get "/users", to: "users#index"
  # get "/users/:id", to: "users#show"
  root "users#index"

  get "logs", to: "logs#index"
  get "logs_of_active_record_method_with_query", to: "logs_of_active_record_method_with_query#index"
  get    'login', to: 'sessions#new'
  post   'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  resources :users
end