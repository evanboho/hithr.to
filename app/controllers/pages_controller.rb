class PagesController < ApplicationController
  def home
    @rides = Ride.paginate(:page => params[:page]).order('created_at DESC').limit(10)
  end

  def about
  end

  def contact
  end

  def help
  end
end
