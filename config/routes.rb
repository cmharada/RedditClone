Rails.application.routes.draw do
  resources :users
  resource :session, only: [:new, :create, :destroy]
  resources :subs
  resources :posts, only: [:new, :edit, :destroy, :show, :create, :update] do
    resources :comments, only: [:new]
  end
  resources :comments, only: [:create, :show]
  resources :votes, only: [:create]
end
