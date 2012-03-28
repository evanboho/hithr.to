class RidesController < ApplicationController

  before_filter :authenticate_user!, :only => [:new, :edit, :update, :destroy]
  before_filter :current_user?, :except => [:index, :show]
  respond_to :html, :json
 
  def index
    @rides = Ride.search(make_criteria).reorder('go_time ASC').paginate(:page => params[:page], :per_page => 15).includes(:user)
    #@rides = Ride.paginate(:page => params[:page], :per_page => 15).search(make_criteria).reorder('go_time ASC')
    if @rides.blank?
      flash.now[:notice] = "Sorry. Try increasing the search radius."    
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
   
  def show
    @ride = Ride.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @ride }
    end
  end

  def new
    @ride = Ride.new
    loc = get_user_ip
    @ride.start_city = loc.city
    @ride.start_state = loc.state_code
    @ride.end_state = loc.state_code
    @ride.go_time = Date.tomorrow
  end

  # GET /rides/1/edit
  def edit
    @ride = Ride.find(params[:id])
  end

  def create
    @ride = current_user.rides.build(params[:ride])
    # gt = @ride.go_time
    # @ride.go_time = "#{gt.year}-#{gt.day}-#{gt.month} #{params[:go_time_hour]}:#{params[:go_time_min]}".to_time
    if @ride.save
      flash[:notice] = "so far so good..."
      redirect_to new_ride_detail_path(@ride)
    else
      render 'new'
    end
  end

  # PUT /rides/1
  # PUT /rides/1.json
  def update
    @ride = Ride.find(params[:id])
    @ride.update_attributes(params[:ride])
    respond_with @ride
    
    # if @ride.update_attributes(params[:ride])
    #       flash[:notice] = "So far so good..."
    #       unless @ride.detail.nil?
    #         redirect_to edit_detail_path(@ride)
    #       else
    #         redirect_to new_ride_detail_option_path(@ride)
    #       end
    #     else
    #       render 'edit'
    # end
  end

  # DELETE /rides/1
  # DELETE /rides/1.json
  def destroy
    @ride = Ride.find(params[:id])
    @ride.destroy

    respond_to do |format|
      format.html { redirect_to rides_url }
      format.json { head :no_content }
    end
  end
end
