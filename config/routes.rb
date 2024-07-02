Rails.application.routes.draw do
  post 'loan_application/create', to: 'loan_application#create'
  root 'loan_application#new'

  get 'loan_application/new', to: 'loan_application#new'
  get 'loan_application/show/:id', to: 'loan_application#show', as: 'loan_application_show'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  # get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
