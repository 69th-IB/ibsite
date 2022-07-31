Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  root 'static_pages#index'

  devise_for :user,
    skip: [:sessions, :registrations],
    controllers: {
      omniauth_callbacks: "user/omniauth_callbacks",
    }

  devise_scope :user do
    delete "sign_out", to: "user/sessions#destroy"
  end

  resources :missions
  put 'slots/:id/enlist/:user_id', to: "slots#enlist", as: :enlist_slot
  delete 'slots/:id/unenlist', to: "slots#unenlist", as: :unenlist_slot

  resources :modlists, only: [:index, :show, :create, :update, :destroy]
  post "modlists/:id/publish", to: "modlists#publish", as: :publish_modlist
  get "modlists/:id/diff/:other_id", to: "modlists#diff", as: :diff_modlist
  get "modlists/:id/preset", to: "modlists#preset", as: :modlist_preset

  namespace :user do
    get 'omniauth_callbacks/discord'
    get 'omniauth_callbacks/steam'
  end

  namespace :admin do
    get "permissions", to: "permissions#index"
    put "permissions/grant", to: "permissions#grant"
    delete "permissions/grant", to: "permissions#ungrant"
  end

  get "/server", to: "manage_server#index", as: :manage_server
  get "/server/logs", to: "manage_server#logs", as: :manage_server_logs
  post "/server/start", to: "manage_server#start", as: :manage_server_start
  post "/server/stop", to: "manage_server#stop", as: :manage_server_stop

  resources :server_configs, only: [:index, :show, :edit, :update]
end
