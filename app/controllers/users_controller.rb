class UsersController < ApplicationController
 
  respond_to :html, :json
  
  before_filter :authenticate_user!, :only => [:edit, :update, :destroy]
  before_filter :current_user?, :except => [:new, :create, :show]
  # before_filter :admin_index, :only => [:index]
  
  helper_method :sort_column, :sort_direction  

  def admin_index
    unless admin?
      flash[:notice] = "you do not have access."
      redirect_to root_path
    end
  end
  
  def index
    if params[:name_search].present?
      @users = User.search(params[:name_search])
    else
      @users = User.scoped
    end
      @users = @users.order(sort_column + ' ' + sort_direction).paginate(:page => params[:page], :per_page => 10)
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
  
  private
  
  def sort_column
    User.column_names.include?(params[:sort]) ? params[:sort] : "last_sign_in_at"
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "desc"
  end
  
end