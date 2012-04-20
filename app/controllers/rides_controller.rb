class RidesController < ApplicationController

  before_filter :authenticate_user!, :only => [:new, :edit, :update, :destroy]
  before_filter :current_user?, :except => [:index, :show, :index_wanted]
  respond_to :html, :json
 
  def index
    @rides = Ride.where(:offered => true).search(make_criteria).reorder('go_time ASC').paginate(:page => params[:page], :per_page => 15).includes(:user)
    #@rides = Ride.paginate(:page => params[:page], :per_page => 15).search(make_criteria).reorder('go_time ASC')
    if @rides.blank?
      flash.now[:notice] = "Sorry. Try increasing the search radius."    
    end
  end
  
  def index_wanted
    @rides = Ride.where('offered <> ?', true)
    @rides = @rides.search(make_criteria).reorder('go_time ASC').paginate(:page => params[:page], :per_page => 15).includes(:user)
    if @rides.blank?
      flash.now[:notice] = "Sorry. Try increasing the search radius."
    end
  end
   
  def user
    @rides = current_user.rides.reorder('created_at DESC').paginate(:page => params[:page], :per_page => 10)
    render 'user_rides'
  end 
  
  def show
    @ride = Ride.find(params[:id])
    @ride.detail ||= Detail.new
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @ride }
    end
  end
  
  def new
    @ride = Ride.new
    loc = get_user_ip
    @ride.start_city = loc.city if loc.present?
    @ride.start_state = loc.state_code if loc.present?
    @ride.go_time = Date.tomorrow
  end
  
  def create
    @ride = current_user.rides.build(params[:ride])
    #find_or_create_cities
    @ride.go_time = @ride.go_time.change(:hour => params[:ride][:go_time_hour], :min => params[:ride][:go_time_min])
    if @ride.save
      flash[:notice] = "ride posted!"
      @ride.detail = Detail.create(:cost => (@ride.trip_distance / 10), 
                                    :seats_available => "1", :radio => "Flexible", 
                                    :bikes => 0, :smoking => 0)
      redirect_to @ride
    else
      flash[:notice] = "something went wrong :("
      render 'new'
    end
  end
  
  def edit
    @ride = Ride.find(params[:id])
  end 
  
  def update
    @ride = Ride.find(params[:id])
    @ride.update_attributes(params[:ride])
    @ride.go_time = @ride.go_time.change(:hour => params[:ride][:go_time_hour], :min => params[:ride][:go_time_min])
    @ride.save
    respond_with @ride
  end
  
  def destroy
    @ride = Ride.find(params[:id])
    @ride.destroy
    respond_to do |format|
      format.html { redirect_to rides_url }
      format.json { head :no_content }
    end
  end
  
  
  
  def make_criteria
    criteria = {}
    if params[:date].present?
      search_date = make_date
    end
    criteria[:search_date] = search_date ||= Date.today
    if params[:search_end].present?
      criteria[:search_end_city] = get_city(params[:search_end])
      criteria[:search_end_state] = get_state(params[:search_end])
    end
    if params[:search_start].present?      
      criteria[:search_start_city] = get_city(params[:search_start])
      criteria[:search_start_state] = get_state(params[:search_start])
    end
    criteria[:miles_radius] = params[:miles_radius].to_i ||= 0
    criteria
  end
   
  def make_date
    Date.civil(params[:date][:year].to_i, params[:date][:month].to_i, params[:date][:day].to_i)
  end
   
  def get_user_ip
    request.location
  end
  
  def get_city(input_string)
    input_string.split(',')[0].strip.titleize
  end  

  def get_state(input_string)
    split_result = input_string.split(',')
    split_result.length > 1 ? split_result[1].strip.upcase : nil
  end
  
end
