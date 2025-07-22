class HabitCheckinsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_habit

  def create
  date = params[:date] ? Date.parse(params[:date]) : Date.today
  existing = @habit.habit_checkins.find_by(date: date)

  if existing.nil?
    @habit.habit_checkins.create(date: date)
  end

  respond_to do |format|
    format.turbo_stream { render turbo_stream: turbo_stream.replace("calendar_#{@habit.id}", partial: "habits/calendar", locals: { habit: @habit }) }
    format.html { redirect_to habit_path(@habit) }
  end
end


  private

  def set_habit
    @habit = current_user.habits.find(params[:habit_id])
  end
end
