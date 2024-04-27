Rails.application.routes.draw do
  devise_for :admin, skip: [:registrarions, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  devise_for :users, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  devise_scope :user do
    post 'users/guest_sign_in', to: 'public/sessions#guest_sign_in'
    get 'users/guest_sign_in', to: 'public/sessions#guest_sign_in'
  end

  root to: "public/homes#top"

  scope module: :public do
    get "home/top" => "homes#top"
    get "about" => "homes#about"
    resources :users, only: [:edit, :update] do
      member do
        get :favorites
      end
    end
    resources :trips do
      member do
        get :schedules_edit
        patch :schedules_update
      end
      resources :posts
    end
    resources :posts, only: [:index, :show, :new, :create, :destroy] do
      resources :comments, only: [:create, :destroy]
      resource :favorites, only: [:create, :destroy]
    end
  end
  patch '/public/trips/:id/edit', to: 'public/trips#update', as: 'update_trip'

  scope module: :public do
    get "users/my_page/:id" => "users#show", as: "users_my_page"
    get "users/information/edit" => "users#edit"
    patch "users/information" => "users#update"
  end

  get "admin" => "admin/homes#top", as: '/admin'
  namespace :admin do
    resources :users, only: [:index, :show, :edit, :update]
    resources :posts, only: [:index, :show]
    resources :comments, only: [:destroy]
  end

  get "search" => "public/searches#search"
  get "search_tag" => "public/posts#search_tag"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end