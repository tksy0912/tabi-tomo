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
    @trip.schedules
  end


  def update
    schedules_params = params.require(:schedules)
     .map { |_, attributes| attributes.permit(:date, :destination, :transportation, :is_accommodation, :accommodation_name) }

    @schedules = Schedule.update(schedules_params.keys, schedules_params.values)

    redirect_to public_trip_path(@schedules.first.trip_id)
  end

  def destroy
    @schedule = Schedule.find(params[:id])
    @schedule.destroy
    redirect_to public_trip_path(@schedule.trip_id)
  end


  private

  def schedule_params
    params.require(:schedule).permit(:date, :destination, :transportation, :is_accommodation, :accommodation_name, :trip_id)
  end
end
