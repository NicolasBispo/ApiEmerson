Rails.application.routes.draw do
  resources :social_links
  resources :campaign_contracts
  resources :company_contracts, except: [:index]
  resources :social_media_descriptors
  resources :campaign_descriptors
  resources :campaigns
  resources :categories
  resources :companies do
    member do
      get "company_contracts", to: "companies#get_company_contracts"
      get "campaign", to: "companies#get_campaigns"
    end
  end
  devise_for :users, path: '', path_names: {
    sign_in: 'login',
    sign_out: 'logout',
    registration: 'signup'
  },
  controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
