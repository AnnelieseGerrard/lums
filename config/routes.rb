Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  get 'submissions/create'
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "pages#home"

  resources :courses, only: [:index, :show] do
    resources :lectures, only: [:create, :new, :show, :edit, :update, :destroy] do 
      member do 
        patch :move
      end
    end
  end
  resources :exercises, only: [] do
    resources :submissions, only: [:create]
  end
end
