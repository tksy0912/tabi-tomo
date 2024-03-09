class Public::SchedulesController < ApplicationController
  def new
    @schedule = Schedule.new
  end

  def create
    @schedule = Schedule.new(schedule_params)
    @schedule.save
    redirect_to public_trip_path(@schedule.trip_id)
  end


  private

  def schedule_params
    params.require(:schedule).permit(:date, :destination, :transportation, :is_accommodation, :accommodation_name, :trip_id)
  end
end
