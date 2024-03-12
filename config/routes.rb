Rails.application.routes.draw do
  devise_for :admin, skip: [:registrarions, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  devise_for :users, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  root to: "public/homes#top"

  namespace :public do
    get "home/top" => "homes#top"
    get "about" => "homes#about"
    resources :users, only: [:new, :create, :show, :edit, :update] do
      member do
        get :favorites
      end
    end
    resources :trips do
      member do
        get :schedules_edit
        patch :schedules_update
      end
    end
    # resources :schedules do
    #   collection do
    #     put 'update_multiple'
    #   end
    # end
    resources :posts, only: [:index, :show, :new, :create, :destroy] do
      resources :comments, only: [:create, :destroy]
      resource :favorites, only: [:create, :destroy]
    end
  end
  patch '/public/trips/:id/edit', to: 'public/trips#update', as: 'update_public_trip'

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

  get "public/search" => "public/searches#search"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
