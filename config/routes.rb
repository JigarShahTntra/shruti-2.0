require "sidekiq/web"

Rails.application.routes.draw do
  Sidekiq::Web.use Rack::Auth::Basic do |username, password|
    username == "jigar" && password == "123456"
  end
  mount Sidekiq::Web => "/sidekiq"
  resources :ideas, only: [ :index, :create, :show ] do
    get "export_pdf", to: "ideas#export_pdf"
    resources :criterias, only: [ :index, :show ] do
      get "fetch_criterias", on: :collection
    end
  end
  get "/ideas/:idea_id/criterias/:criteria_type/show", to: "criterias#show", as: "idea_criteria_show"
  get "/ideas/:idea_id/criterias/:criteria_type/graphs", to: "graphs#index"
  get "/ideas/:idea_id/criteria_mitigations/:criteria_type/show", to: "criteria_mitigations#show"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
