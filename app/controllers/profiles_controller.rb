class ProfilesController < ApplicationController
  
  
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
    if @profile.update_attributes(params[:profile])
      flash[:notice] = "success"
      redirect_to @profile.user
    else
      render 'edit'
    end
  end
  
  def destroy
  end
  
  
end