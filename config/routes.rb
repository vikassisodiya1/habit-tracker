Rails.application.routes.draw do
  require "sidekiq/web"
  mount Sidekiq::Web => "/sidekiq" if Rails.env.development?

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end

  devise_for :users,
    controllers: {
      registrations: "users/registrations"
    }
  root "habits#index"
  resources :habits do
    post "checkin", on: :member
    resources :habit_checkins, only: [ :create ]
  end
end
