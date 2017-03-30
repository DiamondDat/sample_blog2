Rails.application.routes.draw do

  root to: 'static_pages#home'

  get '/help',    to: 'static_pages#help'
  get '/about',   to: 'static_pages#about'
  get '/contact', to: 'static_pages#contact'

  devise_for :users
  resources  :users,        only: [:index, :show] do
    member do
      get :following, :followers
    end
  end
  resources  :microposts,    only: [:create, :destroy]
  resources  :relationships, only: [:create, :destroy]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
