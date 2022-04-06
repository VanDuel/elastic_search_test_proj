Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root 'libraries#index'

  resources :libraries do
    resources :books do
      resources :chapters
    end
  end

  get '/librarysearch', to: 'libraries#search'
  get '/booksearch',    to: 'books#search'
  get '/chaptersearch', to: 'chapters#search'
  # Defines the root path route ("/")
  # root "articles#index"
end
