Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?

  root :to => "web/boards#show"
  get '/up', to: proc { [200, {}, ['OK']] }

  get  'password_resets/new',  to: 'password_resets#new',    as: :new_password_reset
  post 'password_resets',      to: 'password_resets#create', as: :password_resets
  get  'password_resets/edit', to: 'password_resets#edit',   as: :edit_password_reset
  patch 'password_resets',     to: 'password_resets#update', as: :password_reset

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