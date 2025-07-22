json.extract! habit, :id, :name, :description, :user_id, :created_at, :updated_at
json.url habit_url(habit, format: :json)
