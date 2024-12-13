Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  namespace :api do
    resources :players, path: :player
    post "team/team_process", to: "team#team_process"
  end
end
