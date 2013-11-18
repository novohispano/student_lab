StudentLab::Application.routes.draw do
  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure',            to: redirect('/')
  get 'signout',                 to: 'sessions#destroy'

  resources :students do
    resources :one_on_ones
    resources :mentor_reports, controller: "student_mentor_reports"
  end

  resources :mentors
  resources :mentor_reports

  root 'home#show'
end