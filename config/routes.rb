Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :bucketlists, except: [:new, :edit] do
        post "/create", to: "bucketlists#create"
        resources :items, only: [:create, :update, :destroy]
      end
      resources :users
      post "/user/new" => "users#create"
      post "/auth/login" => "sessions#create"
      get "/auth/logout" => "sessions#destroy"
    end
  end
end
