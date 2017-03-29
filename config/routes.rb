Rails.application.routes.draw do
  devise_for :users
  resources :users, only: [:show, :index] do
    post :generate_new_password_email
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
