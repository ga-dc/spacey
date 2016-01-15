Rails.application.routes.draw do
  get "/classroom-utilization", to: "classroom_utilization#index"
end
