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

  namespace :user do
    get 'settings/index'
    get 'omniauth_callbacks/discord'
    get 'omniauth_callbacks/steam'
  end

  resources :missions

  namespace :admin do
    get 'permissions/index'
  end
end
