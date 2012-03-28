module ApplicationHelper
  
  
  
  def username
    "#{firstname.try(:humanize)} #{lastname.to(0).try(:humanize)}"
  end
  
  def msg_time
    t = created_at.strftime("%b %d, %l:%M")
    t = t + ' am' if created_at.hour < 12
    t = t + ' pm' if created_at.hour > 12
    t
  end
  
  def get_search_date
    if params[:date].present?
      "#{params[:date][:year]}-#{params[:date][:month]}-#{params[:date][:day]}".to_date
    else
      Date.today
    end
  end
  
  def go_time_select(form, attribute)
  	hour_list =   [['12 am', 0], ['1 am', 1], ['2 am', 2], ['3 am', 3], ['4 am', 4], ['5 am', 5], ['6 am', 6], ['7 am', 7], ['8 am', 8], 
  	              ['9 am', 9],['10 am', 10], ['11 am', 11], ['12 pm', 12], ['1 pm', 13], ['2 pm', 14], ['3 pm', 15], ['4 pm', 16], 
  	              ['5 pm', 17], ['6 pm', 18], ['7 pm', 19], ['8 pm', 20], ['9 pm', 21],['10 pm', 22], ['11 pm', 23]]
  	form.select(attribute, hour_list, {})    
  end 
  
  def go_time_min_select(form, attribute)
    min_list = ['00', '15', '30', '45']
  	form.select(attribute, min_list, {})    
  end
    
  def state_select(form, attribute)
    state_list = ['AL','AK','AZ','AR','CA','CO','CT','DE','FL','GA','HI','ID','IL','IN',
  					'IA','KS','KY','LA','ME','MD','MA','MI','MN','MS','MO','MT','NE','NV','NH','NJ','NM','NY',
  					'NC','ND','OH','OK','OR','PA','RI','SC','SD','TN','TX','UT','VT','VA','WA','WV','WI','WY']
  	form.select(attribute, state_list, {})
  end
  
  def line_breaks(c)
    return c.split("\n") if !c.nil?
    return [] if c.nil?
  end  
  
end
