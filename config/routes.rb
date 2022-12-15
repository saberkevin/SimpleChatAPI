Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  # api/v1/user

  namespace :api do
    namespace :v1 do
      resources :user
    end
  end
end
 