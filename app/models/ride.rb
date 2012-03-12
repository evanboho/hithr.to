class Ride < ActiveRecord::Base
  
  belongs_to :user
  has_one :detail, :dependent => :destroy
  
  
  validates :user_id, :presence => true
  validates :start_city, :presence => true, 
             :length => { :maximum => 20 }
  validates :start_state, :presence => true
  validates :end_city, :presence => true, 
             :length => { :maximum => 20 }
  validates :end_state, :presence => true
  validates :go_time, :presence => true
  
  before_save :before_save_events
 
  def before_save_events
    clean_up_cities
    geocode_cities
    get_distance
    get_your_bearings
  end
  
  geocoded_by :start_city_state
  
  def start_city_state
    "#{start_city}, #{start_state}"
  end
  
  def geocode_cities
    latlong = geocode_city("#{start_city}, #{start_state}")
    self.latitude = latlong.first
    self.longitude = latlong.last
    latlong = geocode_city("#{end_city}, #{end_state}")
    self.end_lat = latlong.first
    self.end_long = latlong.last
  end
  
  def geocode_city(city_state)
    Geocoder.coordinates(city_state)
  end
    
    
  
  def get_user_ip
    user_location = Geocoder.request
  end
  
  def get_dest_lat_long
    
  end
  
  def get_your_bearings
    dest = end_city + ', ' + end_state
    # destcoords = Geocoder.coordinates(dest)
    self.bearing = Geocoder::Calculations.bearing_between([latitude, longitude], [end_lat, end_long])
  end
  
  def get_distance
    crow_flies = Geocoder::Calculations.distance_between([latitude, longitude], [end_lat, end_long])
    self.trip_distance = ((crow_flies / 100 * 1.12).round(0)) * 100
  end
  
  
  # SEARCH(es)
  
  def self.search(criteria)
    @rides = Ride.where("go_time > ?", criteria[:search_date]).includes(:user)
    if criteria[:search_start_city].present?
      if criteria[:miles_radius].to_i == 0 
        rides = @rides.search_city_state(criteria[:search_start_city], criteria[:search_start_state])
        # if rides.count < 10
        #           criteria[:miles_radius] = 20
        #         else
        @rides = rides
        # end
      end 
      if criteria[:miles_radius].to_i > 1
       rides = @rides.search_near(criteria[:search_start_city], criteria[:search_start_state], criteria[:miles_radius])
        if rides.count < 10
                 criteria[:miles_radius] += 10
                 @rides = @rides.search_near(criteria[:search_start_city], criteria[:search_start_state], criteria[:miles_radius])
               else
         @rides = rides
        end
      end
    end
    unless @rides.empty?
      if criteria[:search_end_city].present?
        rides_dest = @rides.search_destination(criteria[:search_end_city], criteria[:search_end_state])
        if rides_dest.count < 1
          if criteria[:search_start_city].present?
            @rides = @rides.search_direction(criteria)
          else
            @rides = @rides.search_near(criteria[:search_end_city], criteria[:search_end_state], 20)
          end
        end
        @rides = rides_dest
      end
    end
    @rides
  end  
    
  def self.search_city_state(city, state)
    if state.present?
      rides = @rides.where(:start_state => state)
    end
    if city.present?
      rides ||= @rides
      rides = rides.where("start_city LIKE ?", "%#{city}%")
    end
    rides
  end
  
  def self.search_destination(city, state)
    if state.present?
      rides_dest = @rides.where(:end_state => state)
    end
    if city.present?
      rides_dest ||= @rides
      rides_dest = rides_dest.where("end_city LIKE ?", "%#{city}")
    end
  end
  
  def self.search_near(city, state, radius)
    @miles_radius = radius  # necessary? How to set search to current miles_radius?
    near("#{city}, #{state}", radius)
  end
  
  def self.search_direction(criteria)
    search_bearing = Geocoder::Calculations.bearing_between("#{criteria[:search_start_city]}, #{criteria[:search_start_state]}", 
                                                            "#{criteria[:search_end_city]}, #{criteria[:search_end_state]}")
    @rides.where(:bearing => (search_bearing - 20)..(search_bearing + 20))
  end 
  
  def clean_up_cities
    self.start_city = clean_up_city(self.start_city)
    self.end_city = clean_up_city(self.end_city)
  end
  
  def clean_up_city(city)
    c = city.split(',')
    c = c.first
    c.try(:titleize).try(:strip)
  end
  
end
