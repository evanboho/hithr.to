class City < ActiveRecord::Base

  validates_presence_of :name, :lat, :long
  validates_uniqueness_of :name
  before_validation :geocode
  geocoded_by :name, :latitude => :lat, :longitude => :long

end
