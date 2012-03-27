class ProfilesController < ApplicationController
  
  respond_to :html, :json
  
  def new
    @user = User.find(params[:user_id])
    @profile = Profile.new
  end
  
  def create
    @user = User.find(params[:user_id])
    profile = Profile.new(params[:profile])
    profile.user_id = params[:user_id]
    if profile.save
      flash[:notice] = "profile updated"
      redirect_to current_user
    else
      render 'new'
    end
  end
  
  def show
    @user = User.find(params[:user_id])
    @profile = @user.profile
  end
  
  def edit
    @user = User.find(params[:id])
    @profile = @user.profile
    @profile.birthday ||= 1980
    
  end
  
  def update
    @profile = Profile.find(params[:id])
    unless params[:profile][:about] == "click here to create a bio"
      @profile.update_attributes(params[:profile])
      # flash[:notice] = "success"
      respond_with @profile.user
    end
  end
  
  def destroy
  end
  
  
end