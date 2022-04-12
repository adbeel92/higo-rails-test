require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'

  devise_for :users
  
  # Comment out to use React
  root to: 'pages#index'
  %w[about].each do |page|
    get page, to: 'pages#show'
  end

  resources :invoice_processors, only: %i[index] do
    collection do
      post :upload
    end
  end
  resources :invoices, only: %i[index]

  # Uncomment to use React
  # root to: 'react_app#index'
  # get '*path', to: 'react_app#index'
end
