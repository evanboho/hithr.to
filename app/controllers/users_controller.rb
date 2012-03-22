class UsersController < ApplicationController
  
  # before_filter :authenticate_user!, :only => [:edit, :index, :update, :destroy]
  before_filter :current_user?, :except => [:new, :create]
  
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
  end
  
  def destroy
  end
  
  
  
end