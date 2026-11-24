Rails.application.routes.draw do
  mount MissionControl::Jobs::Engine, at: "/jobs"

  root "events#index"
  resources :events, only: [:index, :show] do
    resources :votes, only: :create, controller: "votes"
  end

  get "up" => "rails/health#show", as: :rails_health_check
end
