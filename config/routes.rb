Rails.application.routes.draw do
  get 'welcome/index'

  resources :clock_events, except: :show

  root 'welcome#index'
end
