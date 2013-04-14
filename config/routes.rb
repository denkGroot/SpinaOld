Spina::Engine.routes.draw do
  root to: "pages#index"

  # Sessions
  resources :sessions
  get "login" => "sessions#new"
  get "logout" => "sessions#destroy"

  resource :account do
    member do
      get :style
      get :analytics
      get :social
    end
  end

  resources :pages do
    collection { post :sort }
  end

  resources :page_parts do
    collection { post :sort }
  end

  resources :users
  
  resources :photos do
    member do
      post :enhance
    end
  end
end
