class HabitsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_habit, only: %i[ show edit update destroy checkin ]

  # GET /habits or /habits.json
  def index
    @habits = current_user.habits.includes(:habit_checkins)
    @month = params[:month] ? Date.parse(params[:month]) : Date.today.beginning_of_month
  end

  # GET /habits/1 or /habits/1.json
  def show
  end

  # GET /habits/new
  def new
    @habit = current_user.habits.new
  end

  # GET /habits/1/edit
  def edit
  end

  # POST /habits or /habits.json
  def create
    @habit = current_user.habits.new(habit_params)

    respond_to do |format|
      if @habit.save
        format.html { redirect_to @habit, notice: "Habit was successfully created." }
        format.json { render :show, status: :created, location: @habit }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @habit.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /habits/1 or /habits/1.json
  def update
    respond_to do |format|
      if @habit.update(habit_params)
        format.html { redirect_to @habit, notice: "Habit was successfully updated." }
        format.json { render :show, status: :ok, location: @habit }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @habit.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /habits/1 or /habits/1.json
  def destroy
    @habit.destroy!

    respond_to do |format|
      format.html { redirect_to habits_path, status: :see_other, notice: "Habit was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def checkin
    today = Date.today
    if @habit.habit_checkins.find_by(date: today).blank?
      @habit.habit_checkins.create(date: today)
      flash[:notice] = "Marked as done for today!"
    else
      flash[:alert] = "Already checked in today."
    end
    redirect_to habits_path
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_habit
      @habit = current_user.habits.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def habit_params
      params.require(:habit).permit(:name, :description)
    end
end
