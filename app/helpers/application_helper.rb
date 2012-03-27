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
  	hour_list = ['12 am', '1 am', '2 am', '3 am', '4 am', '5 am', '6 am', '7 am', '8 am', '9 am','10 am', '11 am', 
  	      '12 pm', '1 pm', '2 pm', '3 pm', '4 pm', '5 pm', '6 pm', '7 pm', '8 pm', '9 pm','10 pm', '11 pm']
  	form.select(attribute, hour_list, {}, {class: "chzn-select", class:"auto"})    
  end 
  
  def go_time_min_select(form, attribute)
    min_list = ['00', '15', '30', '45']
  	form.select(attribute, min_list, {}, {class: "chzn-select", class:"auto"})    
  end
    
  def state_select(form, attribute)
    state_list = ['AL','AK','AZ','AR','CA','CO','CT','DE','FL','GA','HI','ID','IL','IN',
  					'IA','KS','KY','LA','ME','MD','MA','MI','MN','MS','MO','MT','NE','NV','NH','NJ','NM','NY',
  					'NC','ND','OH','OK','OR','PA','RI','SC','SD','TN','TX','UT','VT','VA','WA','WV','WI','WY']
  	form.select(attribute, state_list, {})
  end
  
  def line_breaks(c)
    c.split("\n")
  end  
  
end
