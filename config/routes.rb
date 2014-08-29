Rails.application.routes.draw do
  resources :users
  resource :session, only: [:new, :create, :destroy]
  resources :subs do
    resources :posts, only: [:new, :edit, :update, :destroy, :show]
  end
  resources :posts, only: [:create]
end
