class Ride < ActiveRecord::Base
  
  belongs_to :user
  has_one :detail, :dependent => :destroy
  attr_accessor :go_time_hour, :go_time_min
  
  validates :user_id, :presence => true
  validates :start_city, :presence => true, 
             :length => { :maximum => 20 }
  validates :start_state, :presence => true
  validates :end_city, :presence => true, 
             :length => { :maximum => 20 }
  validates :end_state, :presence => true
  validates :go_time, :presence => true
  validates_presence_of :latitude, :longitude, :end_lat, :end_long
  
  before_validation :before_save_events
  
  
  def before_save_events
    find_or_create_cities
    get_distance
    get_your_bearings
  end
  
  geocoded_by :start_city_state
  
  def find_or_create_cities
    s = find_or_create_city(self.start_city, self.start_state)
    e = find_or_create_city(self.end_city, self.end_state)
    self.start_city = s.name.split(', ').first
    self.start_state = s.name.split(', ').last
    self.end_city = e.name.split(', ').first
    self.end_state = e.name.split(', ').last
    self.latitude = s.lat
    self.longitude = s.long
    self.end_lat = e.lat
    self.end_long = e.long
  end
  def find_or_create_city(city, state)
    City.find_or_create_by_name("#{city.try(:titleize).try(:strip)}, #{state.try(:upcase).try(:strip)}") 
  end
  
  def get_lat_long_both
    lat_long = get_lat_long(self.start_city, self.start_state)
    self.latitude = lat_long.first
    self.longitude = lat_long.last
    end_lat_long = get_lat_long(self.end_city, self.end_state)
    self.end_lat = end_lat_long.first
    self.end_long = end_lat_long.last
  end
  
  def get_lat_long(city, state)
    city_state = city + ", " + state
    c = City.find_or_create_by_name(city_state)
    # unless city = City.where(:name => city_state)
    #    city = City.new
    #    city.name = city_state
    #    city.save
    #  end
    return [c.lat, c.long]
  end
  
  
  def start_city_state
    "#{start_city}, #{start_state}"
  end 
  
  def get_user_ip
    user_location = Geocoder.request
  end
  
  def get_your_bearings
    # dest = end_city + ', ' + end_state
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
        rides = @rides.search_start(criteria[:search_start_city], criteria[:search_start_state])
        if rides.count < 1
          criteria[:miles_radius] = 20
        else
          @rides = rides
        end
      end 
      if criteria[:miles_radius].to_i > 1
       rides = @rides.search_near(criteria[:search_start_city], criteria[:search_start_state], criteria[:miles_radius])
        # if rides.count < 5
          # criteria[:miles_radius] += 10
          # @rides = @rides.search_near(criteria[:search_start_city], criteria[:search_start_state], criteria[:miles_radius])
        #else
          @rides = rides
        # end
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
        else
          @rides = rides_dest
        end
      end
    end
    @rides
  end  
    
  def self.search_start(city, state)
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
    near("#{city}, #{state}", radius)
  end
  
  def self.search_direction(criteria)
    search_bearing = Geocoder::Calculations.bearing_between("#{criteria[:search_start_city]}, #{criteria[:search_start_state]}", 
                                                            "#{criteria[:search_end_city]}, #{criteria[:search_end_state]}")
    @rides.where(:bearing => (search_bearing - 20)..(search_bearing + 20))
  end 
  
end
