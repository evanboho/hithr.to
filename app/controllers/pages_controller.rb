class PagesController < ApplicationController
  def home
    @rides = Ride.order('created_at DESC')
    @rides = @rides.paginate(:page => params[:page], :per_page => 5)
  end

  def about
  end

  def contact
    @user = current_user
    @user = User.first #User.where(:firstname => "admin").first
    @message = Message.new
  end

  def help
  end
end
