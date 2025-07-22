class HabitCheckinsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_habit

  def create
    date = params[:date] ? Date.parse(params[:date]) : Date.today
    existing = @habit.habit_checkins.find_by(date: date)

    if existing
      flash[:alert] = "Already marked as done for #{date.to_s(:long)}"
    else
      @habit.habit_checkins.create(date: date)
      flash[:notice] = "Marked as done for #{date.to_s(:long)}"
    end

    redirect_to habit_path(@habit)
  end

  private

  def set_habit
    @habit = current_user.habits.find(params[:habit_id])
  end
end
