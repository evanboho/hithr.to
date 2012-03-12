module ProfilesHelper

  def distance_in_years(birthday)
    today = (Date.today.year * 365.25) + (Date.today.month * 30.44) + Date.today.day
    burfday = (birthday.year * 365.25) + (birthday.month * 30.44) + birthday.day
    yrs_old = (today - burfday)/365.25
    a = yrs_old.to_s.split('.')
    if a.last.first == "0"
      a.first
    else
      a.first + '.' + a.last.first
    end
  end

  
  
end