Rails.application.routes.draw do
  resources :clock_events, except: :show
  root 'clock_events#index'
end
