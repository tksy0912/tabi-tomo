class Public::TripsController < ApplicationController
  def new
    @trip = Trip.new
    @schedule = Schedule.new
  end

  def create
    @trip = Trip.new(trip_params)
    @trip.user_id = current_user.id

    if @trip.save
      @schedule = Schedule.new(schedule_params)
      @schedule.trip_id = @trip.id # スケジュールのtrip_idに作成した旅行のIDを代入
      if @schedule.save
        redirect_to public_trip_path(@trip)
      else
        render :new
      end
    else
      render :new
    end
  end

  def show
    @trip = Trip.find(params[:id])
    @schedule = @trip.schedules
  end

  private

  def trip_params
    params.require(:trip).permit(:title, :departure_date, :return_date, :user_id, :schedule_id)
  end
end
