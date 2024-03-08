Rails.application.routes.draw do
  devise_for :admin, skip: [:registrarions, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  devise_for :users, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  root to: "public/homes#top"

  get "home/top" => "homes#top"
  get "about" => "homes#about"
  resources :users, only: [:new, :create]
  resources :trips
  resources :posts, only: [:index,:show,:edit,:create,:destroy,:update] do
    resources :comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
  end

  scope module: :public do
    get "users/my_page" => "users#show"
    get "users/information/edit" => "users#edit"
    patch "users/information" => "users#update"
  end

  get "admin" => "admin/homes#top"
  namespace :admin do
    resources :users, only: [:index, :show, :edit, :update]
    resources :comments, only: [:destroy]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
