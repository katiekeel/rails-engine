Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      namespace :items do
        get "/find", to: "search#show"
        get "/find_all", to: "search#index"
        get "/random.json", to: "random#show"
      end
      resources :items, only: [:index, :show]
      resources :invoices, only: [:index, :show]
      resources :invoice_items, only: [:index, :show]
      namespace :merchants do
        get "/find", to: "search#show"
      end
      resources :merchants, only: [:index, :show] 
    end
  end
end
