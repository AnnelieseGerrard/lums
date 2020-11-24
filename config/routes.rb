Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "pages#home"

  resources :courses, only: [:show] do
    resources :lectures, only: [:create, :new, :show]
  end
  resources :exercises, only: [:show] do
    resources :submissions, only: [:create]
  end
end
