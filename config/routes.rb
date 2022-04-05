Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root "libraries#index"
  resources :libraries do
    resources :books
  end
  # Defines the root path route ("/")
  # root "articles#index"
end
