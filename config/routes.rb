Rails.application.routes.draw do
  get "/classroom-utilization", to: "classroom_utilization#index"
  get "/days/:date", to: 'events#show_date'
  root to: 'events#index'
  resources :spaces do
    resources :events
  end
  resources :events
end
