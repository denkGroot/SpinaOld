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

    resources :page_parts do
      post :sort, on: :collection
    end

    resources :photos do
      post :enhance, on: :member
    end

    resources :inquiries do
      get :inbox, on: :collection
      post :mark_as_read, on: :member
    end

    # Plugin routes
    Spina.plugins.each do |plugin|
      resources plugin.class_name.pluralize.downcase.to_sym
    end

  end

  Spina.plugins.each do |plugin|
    resources plugin.class_name.pluralize.downcase.to_sym
  end
  
  # Frontend
  root to: "pages#homepage"
  resources :pages, path: ''
  resources :inquiries
end
