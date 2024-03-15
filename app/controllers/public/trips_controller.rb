class Public::TripsController < ApplicationController
  def new
    @trip = Trip.new
    @trip.schedules.build
  end

  def create
    @trip = Trip.new(trip_params)
    @trip.user_id = current_user.id
    if @trip.save
      flash[:notice] = "success"
      redirect_to public_trip_path(@trip)
    else
      flash.now[:alert] = "failed"
      render :new
    end
  end

  def edit
    @trip = Trip.find(params[:id])
  end
  
  def schedules_edit
    @trip = Trip.find(params[:id])
    @trip.schedules
  end

  def update
    @trip = Trip.find(params[:id])
    if @trip.update(trip_params)
      flash[:notice] = "success"
      redirect_to public_trip_path(@trip.id)
    else
      flash.now[:alert] = "failed"
      render :edit
    end
  end
  
  def schedules_update
    @trip = Trip.find(params[:id])
    if @trip.update(trip_with_schedules_params)
      flash[:notice] = "success"
      redirect_to public_trip_path(@trip.id)
    else
      flash.now[:alert] = "failed"
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
    redirect_to users_my_page_path
  end

  private

  def trip_params
    params.require(:trip).permit(:title, :departure_date, :return_date, :user_id, :schedule_id, schedules_attributes: [:id, :date, :destination, :transportation, :is_accommodation, :accommodation_name, :trip_id, :_destroy])
  end
  
  def trip_with_schedules_params
    params.require(:trip).permit(schedules_attributes: [:id, :date, :destination, :transportation, :is_accommodation, :accommodation_name, :trip_id, :_destroy])
  end
end
