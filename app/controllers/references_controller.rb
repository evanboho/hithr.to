class ReferencesController < ApplicationController


  def new
    @user = User.find(params[:user_id])
    if Reference.find_by_user_id_and_sender_id(params[:user_id], current_user.id).present?
      flash[:warning] = "you may only leave one reference for someone"
      redirect_to @user
    else
      @reference = Reference.new
    end
  end

  def create
    @user = User.find(params[:user_id])
    if Reference.find_by_user_id_and_sender_id(params[:user_id], current_user.id).present?
      flash[:warning] = "you may only leave one reference"
      redirect_to @user
    else
      @reference = @user.references.build(params[:reference])
      @reference.sender_id = current_user.id
      @reference.positive = 0 if @reference.positive == ""
      if @reference.save
        @user.profile.cred += @reference.positive
        @user.profile.save
        flash[:notice] = "reference submitted!"
        redirect_to @user
      else
        # flash[:notice] = "error"
        render 'new'
      end
    end
  end
  
  def destroy
    @reference = Reference.find(params[:id])
    @user = @reference.user
    @user.profile.cred -= @reference.positive
    @user.profile.save
    @reference.destroy
    flash[:warning] = "reference deleted"
    redirect_to @user
  end

end