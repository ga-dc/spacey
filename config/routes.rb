Rails.application.routes.draw do
  get "/classroom-utilization", to: "classroom_utilization#index"
  root to: 'events#index'
  resources :spaces do
    resources :events, shallow: true
  end
end
