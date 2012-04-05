class UsersController < ApplicationController
 
  respond_to :html, :json
  
  before_filter :authenticate_user!, :only => [:edit, :update, :destroy]
  before_filter :current_user?, :except => [:new, :create, :show]
  
  def index
    @users = User.all
  end
  
  def show
    @user = User.find(params[:id])
    @mutual_messages = Message.order('created_at DESC').limit(5).mutual_messages(@user, current_user)
  end
  
  def new
    
    
  end
  
  def create
  end
  
  def edit_fields
    
  end
  
  def update
    @user = User.find(params[:id])
    @user.update_attributes(params[:user])
    respond_with @user
  end
  
  def destroy
  end
  
  
  
end