require "sidekiq/web"

Rails.application.routes.draw do
  resources :ratings
  resources :idea_parameter_recommendation_details
  resources :idea_parameter_details
  resources :parameter_recommendations
  resources :stage_gate_parameters
  resources :idea_stage_gates
  Sidekiq::Web.use Rack::Auth::Basic do |username, password|
    username == "jigar" && password == "123456"
  end
  mount Sidekiq::Web => "/sidekiq"
  namespace :api do
    namespace :v1 do
      resources :ideas, only: [ :index, :create, :show ] do
        get "export_pdf", to: "ideas#export_pdf"
        resources :stage_gates
        #   resources :criterias, only: [ :index, :show ] do
        #     get "fetch_criterias", on: :collection
        #   end
      end
    end
  end
  # get "/ideas/:idea_id/criterias/:criteria_type/show", to: "criterias#show", as: "idea_criteria_show"
  # get "/ideas/:idea_id/criterias/:criteria_type/graphs", to: "graphs#index"
  # get "/ideas/:idea_id/criteria_mitigations/:criteria_type/show", to: "criteria_mitigations#show"
  # get "news", to: "news#index"
  # # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # # Can be used by load balancers and uptime monitors to verify that the app is live.
  # get "up" => "rails/health#show", as: :rails_health_check
  resources :stage_gates do
    resources :stage_gate_parameters do
      resources :parameter_recommendations
    end
  end
  # Defines the root path route ("/")
  root "stage_gates#index"
end
