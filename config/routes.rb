StudentLab::Application.routes.draw do
  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure',            to: redirect('/')
  get 'signout',                 to: 'sessions#destroy'

  get 'feed', to: 'feed#show'

  resources :students, except: [:index] do
    resources :one_on_ones
  end

  resources :mentors

  root 'home#show'
end