Rails.application.routes.draw do
  devise_for :users,
    controllers: {
      registrations: "users/registrations",
      sessions: "users/sessions"
    }
  root "habits#index"
  resources :habits do
    post "checkin", on: :member
    resources :habit_checkins, only: [ :create ]
  end
end
