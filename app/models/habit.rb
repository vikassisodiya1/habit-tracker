class Habit < ApplicationRecord
  belongs_to :user
  has_many :habit_checkins, dependent: :destroy

  validates :name, presence: true



  def current_streak
    dates = habit_checkins.order(date: :desc).pluck(:date)
    streak = 0
    day = Date.today

    dates.each do |d|
      break unless d == day
      streak += 1
      day -= 1
    end
    streak
  end

  def longest_streak
    dates = habit_checkins.order(:date).pluck(:date)
    return 0 if dates.empty?

    longest = current = 1

    dates.each_cons(2) do |a, b|
      if b == a + 1
        current += 1
      else
        longest = [ longest, current ].max
        current = 1
      end
    end

    [ longest, current ].max
  end

  def consistency_percentage
    return 0 if habit_checkins.empty?

    days_tracked = (Date.today - created_at.to_date).to_i + 1
    ((habit_checkins.count.to_f / days_tracked) * 100).round(1)
  end
end
