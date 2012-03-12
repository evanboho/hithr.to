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
      flash[:success] = "...all done!"
      redirect_to @ride
    else
      render 'new'
    end 
  end
  
  def edit
    
  end
  
  def update
  end
  
  def destroy
  end
  
end