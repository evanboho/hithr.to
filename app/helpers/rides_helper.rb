module RidesHelper

  def compass_points(bearing)
    return "North" if 0 <= bearing && bearing <= 22.5 || 337.5 < bearing && bearing <= 360
    return "Northeast" if 22.5 < bearing && bearing <= 67.5
    return "East" if 67.5 < bearing && bearing <= 112.5
    return "Southeast" if 112.5 < bearing && bearing <= 157.5
    return "South" if 157.5 < bearing && bearing <= 202.5
    return "Southwest" if 202.5 < bearing && bearing <= 247.5
    return "West" if 247.5 < bearing && bearing <= 292.5
    return "Northwest" if 292.5 < bearing && bearing <= 337.5
  end

  def ridetime(ride)
    day = ride.go_time.strftime("%a")
    date = ride.go_time.strftime("%b %d")
    if ride.go_time.hour < 12
      hour = ride.go_time.strftime("%l") + "am"
    else
      hour = ride.go_time.strftime("%l") + "pm"
    end
    [day, date, hour]
  end

end
