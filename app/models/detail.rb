class Detail < ActiveRecord::Base
  
  belongs_to :ride
  
  # after_save :get_cost
  #  
  #  def get_cost
  #    d = 
  #    self.cost = (ride.trip_distance / 100).round 
  #    self.save  
  #  end
  
end
