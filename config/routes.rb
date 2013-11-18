StudentLab::Application.routes.draw do
  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure',            to: redirect('/')
  get 'signout',                 to: 'sessions#destroy'

  resources :students do
    resources :one_on_ones
  end

  resources :mentors do
    resources :mentor_reports
  end

  root 'home#show'
end