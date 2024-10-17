Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  Rails.application.routes.draw do
    resource :cart, only: [ :show ] do
      post 'add_product/:product_id', to: 'carts#add_product', as: 'add_product'
      delete 'remove_product/:product_id', to: 'carts#remove_product', as: 'remove_product'
      post 'checkout', to: 'carts#checkout', as: 'checkout'
    end

    root 'carts#show'
  end

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  # root "posts#index"
end
