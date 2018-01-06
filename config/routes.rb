Rails.application.routes.draw do
  root 'questions#index'

  devise_for :users

  resources :questions do
    resource :answers, only: [:create]
    resource :votes, only: [:create, :destroy]
    resources :comments, only: [:create]
  end
  resources :answers do
    resources :comments, only: [:create]
    resource :votes, only: [:create, :destroy]
  end
end
