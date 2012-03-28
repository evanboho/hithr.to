class DetailsController < ApplicationController
  
  def index
    
  end
  
  
  def new
    @ride = Ride.find(params[:ride_id])
    @detail = Detail.new
  end
  
  def create
    @ride = Ride.find(params[:ride_id])
    @detail = @ride.build_detail(params[:detail])
    if @detail.save
      flash[:notice] = "...all done!"
      redirect_to @ride
    else
      render 'new'
    end 
  end
  
  def edit
    @ride = Ride.find(params[:id])
    @detail = @ride.detail
  end
  
  def update
    @detail = Detail.find(params[:id])
    @ride = @detail.ride
    if @detail.update_attributes(params[:detail])
      flash[:notice] = "Roger that." unless @ride.user.firstname == "Roger"
      flash[:notice] = "Roger, roger." if @ride.user.firstname == "Roger"
      redirect_to @ride
    else
      render 'edit'
    end
  end
  
  def destroy
  end
  
end