Rails.application.routes.draw do
  devise_for :users, path: '', path_names: {
    sign_in: 'login',
    sign_out: 'logout',
    registration: 'signup'
  },
  controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  # resources :social_links
  # resources :social_media_descriptors
  
  # resources :categories
  # config/routes.rb
  resources :companies do
    resources :company_contracts, only: [:index, :show, :create, :update, :destroy]
    resources :campaigns, only: [:index, :show, :create, :update, :destroy] do
      resources :campaign_contracts, only: [:index, :show, :create, :update, :destroy]
      resources :campaign_descriptors
    end
  end


  get "users/me", to: "users#me"
  get "users/me/company_contracts", to: "users#get_company_contracts"
  get "users/me/campaign_contracts", to: "users#get_compaign_contracts"
  get "users/me/social_links", to: "social_links#index"
  get "users/me/social_links/:id", to: "social_links#show"
  post "users/me/social_links", to: "social_links#create"
  put "users/me/social_links/:id", to: "social_links#update"
  delete "users/me/social_links/:id", to: "social_links#destroy"
  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
