Rails.application.routes.draw do
  get "/classroom-utilization", to: "classroom_utilization#index"
  get "/days/:date", to: 'events#show_date'
  get "/weeks/:year/:number", to: 'events#show_week'
  root to: 'events#show_date'
  get 'events/check_availability', to: 'events#check_availability'
  get "/auth/:provider/callback", to: "sessions#create"
  get "/logout", to: "sessions#destroy"
  resources :spaces do
    resources :events
  end
  resources :event_types
  resources :recurring_events
  resources :events do
    resources :notes
  end
  get 'settings', to: 'settings#index'
end
