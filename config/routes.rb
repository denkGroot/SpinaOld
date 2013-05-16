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

    resources :pages do
      post :sort, on: :collection
    end

    resources :photos do
      member do
        post :enhance
        get :link
      end
    end

    resources :inquiries do
      get :inbox, on: :collection
      put :mark_as_read, on: :member
      get :spam, on: :collection      
      put :unmark_spam, on: :member
    end

    # Plugin routes
    Spina::Engine.config.plugins.each do |plugin|
      resources plugin.controller.downcase.to_sym
    end
  end

  Spina::Engine.config.plugins.each do |plugin|
    resources plugin.controller.downcase.to_sym, path: plugin.path
  end
  
  # Frontend
  root to: "pages#homepage"
  resources :pages, path: ''
end
