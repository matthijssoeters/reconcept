Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get 'index', to: "astronomy#index"
  post 'lunar_phase', to: "astronomy#lunar_phase"

  root to: "astronomy#index"
end
