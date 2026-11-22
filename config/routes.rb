Rails.application.routes.draw do
  mount MissionControl::Jobs::Engine, at: "/jobs"

  root "events#index"
  resources :events, only: :index

  get "up" => "rails/health#show", as: :rails_health_check
end
