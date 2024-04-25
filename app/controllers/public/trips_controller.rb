class Public::TripsController < ApplicationController
  def new
    @trip = Trip.new
    # schedulesも同時に作成
    @trip.schedules.build
  end

  def create
    @trip = Trip.new(trip_params)
    @trip.user_id = current_user.id
    if @trip.save
      flash[:notice] = "新しい旅行プランを作成しました！"
      redirect_to public_trip_path(@trip)
    else
      flash.now[:alert] = "旅行プランを作成できませんでした"
      render :new
    end
  end

  def edit
    @trip = Trip.find(params[:id])
    if @trip.user_id != current_user.id
      flash[:alert] = "他のユーザーの旅行プランは編集できません"
      redirect_to users_my_page_path(current_user)
    end
  end

  def schedules_edit
    @trip = Trip.find(params[:id])
    @trip.schedules
    if @trip.user_id != current_user.id
      flash[:alert] = "他のユーザーの旅行プランは編集できません"
      redirect_to users_my_page_path(current_user)
    end
  end

  def update
    @trip = Trip.find(params[:id])
    @trip.user_id = current_user.id
    if @trip.update(trip_params)
      flash[:notice] = "更新しました！"
      redirect_to public_trip_path(@trip.id)
    else
      flash.now[:alert] = "更新できませんでした"
      render :edit
    end
  end

  def schedules_update
    @trip = Trip.find(params[:id])
    @trip.user_id = current_user.id
    if @trip.update(trip_with_schedules_params)
      flash[:notice] = "スケジュールを更新しました！"
      redirect_to public_trip_path(@trip.id)
    else
      flash.now[:alert] = "スケジュールの更新ができませんでした"
      render :schedules_edit
    end
  end

  def index
    @trips = Trip.all
  end

  def show
     @trip = Trip.find(params[:id])
     @schedules = @trip.schedules
     @schedule = Schedule.new
     @schedule.trip = @trip
  end

  def destroy
    @trip = Trip.find(params[:id])
    @trip.destroy
    redirect_to users_my_page_path(current_user)
  end

  private

  def trip_params
    params.require(:trip).permit(:title, :start_time, :end_time, :user_id, :schedule_id, schedules_attributes: [:id, :date, :destination, :transportation, :is_accommodation, :accommodation_name, :trip_id, :_destroy])
  end

  def trip_with_schedules_params
    params.require(:trip).permit(schedules_attributes: [:id, :date, :destination, :transportation, :is_accommodation, :accommodation_name, :trip_id, :_destroy])
  end
end
