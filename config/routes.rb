Rails.application.routes.draw do
  root "home#index"

  get "intake", to: "intake#new"
  get "admin/intakes", to: "intake#index"
  post "intake", to: "intake#create"
end
