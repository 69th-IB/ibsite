Rails.application.routes.draw do
  namespace :users do
    get 'omniauth_callbacks/discord'
    get 'omniauth_callbacks/steam'
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  root 'static_pages#index'

  devise_for :user,
    skip: [:sessions, :registrations],
    controllers: {
      omniauth_callbacks: "users/omniauth_callbacks",
    }
end
