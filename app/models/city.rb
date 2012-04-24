class City < ActiveRecord::Base

  validates_presence_of :name, :lat, :long
  validates_uniqueness_of :name
  before_validation :geocode
  after_validation :reverse_geocode
  geocoded_by :name, :latitude => :lat, :longitude => :long
  reverse_geocoded_by :lat, :long do |obj, results|
    if geo = results.first
      obj.name = geo.city + ', ' + geo.state_code
    end
  end
  
end
