class HabitCheckinsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_habit

  def create
    date = params[:date].to_date
    current_month = params[:month].present? ? Date.parse(params[:month]) : date.beginning_of_month

    # @habit.habit_checkins.find_or_create_by(date: date)

    checkin = @habit.habit_checkins.build(date: date)


    if checkin.save
      flash.now[:notice] = "Marked as done for #{date.strftime('%B %d')}!"
    else
      flash.now[:alert] = "Already checked in for #{date.strftime('%B %d')}."
    end

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: [
          turbo_stream.replace("calendar_#{@habit.id}", partial: "habits/calendar", locals: { habit: @habit, current_month: current_month }),
          turbo_stream.replace("habit_#{@habit.id}_badges", partial: "habits/badges", locals: { habit: @habit }),
          turbo_stream.append("flash", partial: "shared/flash")
        ]
      end
      format.html { redirect_to root_path }
    end
  end


  private

  def set_habit
    @habit = current_user.habits.find(params[:habit_id])
  end
end
