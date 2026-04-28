Rails.application.routes.draw do
  root "home#index"

  resources :intakes, only: [:index, :new, :create, :show]
end
