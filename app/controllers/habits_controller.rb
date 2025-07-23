class HabitsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_habit, only: %i[ edit update destroy ]

  def index
    @habits = current_user.habits.includes(:habit_checkins)
    @month = params[:month] ? Date.parse(params[:month]) : Date.today.beginning_of_month
      if request.headers["Turbo-Frame"]
        habit = @habits.find(params[:habit_id])
        render partial: "habits/calendar", locals: { habit: habit }
      end
  end

  def new
    @habit = current_user.habits.new
  end

  def edit
  end

  def create
    @habit = current_user.habits.new(habit_params)

    respond_to do |format|
      if @habit.save
        format.html { redirect_to root_path, notice: "Habit was successfully created." }
        format.json { render :show, status: :created, location: @habit }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @habit.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @habit.update(habit_params)
        format.html { redirect_to root_path, notice: "Habit was successfully updated." }
        format.json { render :show, status: :ok, location: @habit }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @habit.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @habit.destroy!

    respond_to do |format|
      format.html { redirect_to habits_path, status: :see_other, notice: "Habit was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def set_habit
      @habit = current_user.habits.find(params[:id])
    end

    def habit_params
      params.require(:habit).permit(:name, :description)
    end
end
