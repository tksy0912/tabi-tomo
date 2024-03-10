class Public::TripsController < ApplicationController
  def new
    @trip = Trip.new
    @schedule = Schedule.new
  end

  def create
    @trip = Trip.new(trip_params)
    @trip.user_id = current_user.id
    @trip.save
    redirect_to edit_public_trip_path(@trip)
  end

  def edit
    @trip = Trip.find(params[:id])
    @schedules = @trip.schedules
    @schedule = Schedule.new
    @schedule.trip = @trip
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
    redirect_to users_my_page_path
  end

  private

  def trip_params
    params.require(:trip).permit(:title, :departure_date, :return_date, :user_id, :schedule_id)
  end
end
