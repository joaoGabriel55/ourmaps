Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", :as => :rails_health_check

  post "/auth/login", to: "authentication#login"

  resources :users
  resources :custom_maps, only: [:index, :show, :create, :update, :destroy] do
    patch "/collaborators", to: "custom_maps#add_collaborators"
    delete "/collaborators", to: "custom_maps#remove_collaborators"
  end
end
