Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
  mount Sidekiq::Web => '/admin/sidekiq'

  root :to => "web/boards#show"
  get '/up',                   to: proc { [200, {}, ['OK']] }

  resource :password_resets, only: [:new, :create, :edit] do
    patch :update, on: :collection
  end

  put 'attach_image',          to: 'images#attach_image'
  put 'remove_image',          to: 'images#remove_image'

  scope module: :web do
    resource :board, only: :show
    resource :session, only: [:new, :create, :destroy]
    resources :developers, only: [:new, :create]
  end

  namespace :admin do
    resources :users
  end

  namespace :api do
    namespace :v1 do
      resources :tasks, only: [:index, :show, :create, :update, :destroy]
      resources :users, only: [:index, :show]
    end
  end
end