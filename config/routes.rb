Rails.application.routes.draw do
  get "/classroom-utilization", to: "classroom_utilization#index"
  get "/days/:date", to: 'events#show_date'
  root to: 'events#show_date'
  get 'events/check_availability', to: 'events#check_availability'
  resources :spaces do
    resources :events
  end
  resources :event_types
  resources :events
  get 'settings', to: 'settings#index'
end
