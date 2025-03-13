Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  resources :chapters, only: [ :index, :show ] do
  end

  # Defines the root path route ("/")
  # root "posts#index"
  authenticated :user do
    get "my-dashboard", to: "pages#dashboard", as: :dashboard
  end

  resources :lectures, only: [ :show ] do
    member do
      post :mark_as_done
    end

    resources :meetings, only: [ :create ]
  end
end
