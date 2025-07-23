Rails.application.routes.draw do
  devise_for :users,
    controllers: {
      registrations: "users/registrations"
    }
  root "habits#index"
  resources :habits do
    post "checkin", on: :member
    resources :habit_checkins, only: [ :create ]
  end

  get "/habit_checkins/:id/calendar", to: "habit_checkins#show_calendar", as: :habit_calendar
end
