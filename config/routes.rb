Rails.application.routes.draw do
  resources :posts do
    collection do
      post :confirm
    end
  end
  
  resources :sessions, only: [:new, :create, :destroy]
  
  resources :users do
    member do
      get :favorite_post
    end
  end

  resources :favorites, only: [:create, :destroy, :index]

  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
end
