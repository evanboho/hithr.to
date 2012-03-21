class PagesController < ApplicationController
  def home
    @rides = Ride.order('created_at DESC')
    @rides = @rides.paginate(:page => params[:page], :per_page => 15).limit(5)
  end

  def about
  end

  def contact
  end

  def help
  end
end
