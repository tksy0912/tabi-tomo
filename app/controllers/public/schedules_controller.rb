class Public::SchedulesController < ApplicationController
  def new
    @trip = Trip.find(params[:trip_id])
    @schedule = Schedule.new
    @schedules = @trip.schedules
    @schedule.trip = @trip
  end

  def create
    @schedule = Schedule.new(schedule_params)
    @schedule.save!
    redirect_to public_trip_path(@schedule.trip_id)
  end

  def edit
    @trip = Trip.find(params[:id])
    @schedules = @trip.schedules
  end

  def update
    @schedule.update(schedule_params)
    redirect_to public_trip_path(@trip.id)
  end

  private

  def schedule_params
    params.require(:schedule).permit(:date, :destination, :transportation, :is_accommodation, :accommodation_name, :trip_id)
  end
end
