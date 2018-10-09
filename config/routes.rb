Rails.application.routes.draw do
  get 'welcome/index'

  resources :clock_events

  root 'welcome#index'
end
