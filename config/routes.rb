Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get "/patient", to: "patient#index"
  get "/patient/:id", to: "patient#show"
  post "/patient/create", to: "patient#create"
  get "/patient/:id/edit", to: "patient#edit"
  patch "/patient/:id/update", to: "patient#update"
  delete "/patient/:id/destroy", to: "patient#destroy"

  resources :patient
end
