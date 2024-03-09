class Public::TripsController < ApplicationController
  def new
    @trip = Trip.new
    @schedule = Schedule.new
  end

  def create
    @trip = Trip.new(trip_params)
    @trip.user_id = current_user.id
    @trip.save
    redirect_to public_trip_path(@trip)
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
