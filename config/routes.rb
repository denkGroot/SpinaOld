Spina::Engine.routes.draw do

  # Backend
  namespace :admin do
    root to: "pages#index"

    resource :account do
      member do
        get :style
        get :analytics
        get :social
      end
    end

    resources :users
    
    # Sessions
    resources :sessions
    get "login" => "sessions#new"
    get "logout" => "sessions#destroy"

    # Media library
    get 'media_library' => 'photos#index', as: "media_library"
    get 'photo_select/:page_part_id' => 'photos#photo_select', as: "photo_select"
    post 'photo_select/:page_part_id' => 'photos#insert_photo', as: "insert_photo"

    resources :pages do
      post :sort, on: :collection
    end

    resources :photos do
      member do
        post :enhance
        get :link
      end
    end

    resources :inquiries, only: [:index, :show, :destroy] do
      collection do
        get :inbox
        get :spam
      end
      member do
        patch :mark_as_read
        patch :unmark_spam
      end
    end

    # Plugin routes
    Spina::Engine.config.plugins.each do |plugin|
      resources plugin.controller.downcase.to_sym
    end
  end

  Spina::Engine.config.plugins.each do |plugin|
    resources plugin.controller.downcase.to_sym, path: plugin.path
  end

  # Sitemap
  resource :sitemap
  
  # Frontend
  root to: "pages#homepage"

  get ':root/:subpage/:id' => "pages#show", as: "third_level_page"
  get ':root/:id' => "pages#show", as: "subpage"
  get ':id' => "pages#show", as: "page"
end
