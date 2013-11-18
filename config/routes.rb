StudentLab::Application.routes.draw do
  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure',            to: redirect('/')
  get 'signout',                 to: 'sessions#destroy'

  resources :students do
    resources :one_on_ones
  end

  resources :mentors
  resources :mentor_reports

  root 'home#show'
end