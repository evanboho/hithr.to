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
  
  def go_time_select(form, attribute, default)
  	hour_list =   [['12 am', 0], ['1 am', 1], ['2 am', 2], ['3 am', 3], ['4 am', 4], ['5 am', 5], ['6 am', 6], ['7 am', 7], ['8 am', 8], 
  	              ['9 am', 9],['10 am', 10], ['11 am', 11], ['12 pm', 12], ['1 pm', 13], ['2 pm', 14], ['3 pm', 15], ['4 pm', 16], 
  	              ['5 pm', 17], ['6 pm', 18], ['7 pm', 19], ['8 pm', 20], ['9 pm', 21],['10 pm', 22], ['11 pm', 23]]
  	form.select(attribute, hour_list, { :selected => default } )    
  end 
  
  def go_time_min_select(form, attribute, default)
    min_list = ['00', '15', '30', '45']
  	form.select(attribute, min_list, { :selected => default } )    
  end
    
  def state_select(form, attribute)
    state_list = ['(state)','- US -', 'AL','AK','AZ','AR','CA','CO','CT','DE','FL','GA','HI','ID','IL','IN',
   					'IA','KS','KY','LA','ME','MD','MA','MI','MN','MS','MO','MT','NE','NV','NH','NJ','NM','NY',
   					'NC','ND','OH','OK','OR','PA','RI','SC','SD','TN','TX','UT','VT','VA','WA','WV','WI','WY',
   					'-CAN-','AB','BC','MB','NL','NT','NS','NU','ON','PE','QC','SK','YT']
  	form.select(attribute, state_list, {}, :class => "state_select")
  end
  
  def best_state_list
    [[nil, '(state)'],[nil, '- US -'], ['AL', 'AL'],['AK', 'AK'],['AZ', 'AZ'],['AR', 'AR'],['CA', 'CA'],['CO', 'CO'],['CT', 'CT'],['DE', 'DE'],['FL', 'FL'],
    ['GA', 'GA'],['HI', 'HI'],['ID', 'ID'],['IL', 'IL'],['IN', 'IN'],
   	['IA', 'IA'],['KS', 'KS'],['KY', 'KY'],['LA', 'LA'],['ME', 'ME'],['MD','MD'],
   	['MA', 'MA'],['MI', 'MI'],['MN', 'MN'],['MS', 'MS'],['MO', 'MO'],['MT','MT'],['NE','NE'],['NV','NV'],['NH','NH'],['NJ','NJ'],
   	['NM','NM'],['NY','NY'],['NC','NC'],['ND','ND'],['OH','OH'],['OK','OK'],['OR','OR'],['PA','PA'],['RI','RI'],['SC','SC'],
   	['SD','SD'],['TN','TN'],['TX','TX'],['UT','UT'],['VT','VT'],['VA','VA'],['WA','WA'],['WV','WV'],['WI','WI'],['WY','WY'],
   	[nil, '-CAN-'],['AB','AB'],['BC','BC'],['MB','MB'],['NL','NL'],['NT','NT'],['NS','NS'],['NU','NU'],['ON','ON'],
   	['PE','PE'],['QC','QC'],['SK','SK'],['YT','YT']]
  end
  
  def line_breaks(c)
    return c.split("\n") if !c.nil?
    return [] if c.nil?
  end 
  
  def sortable(column, title = nil)
    title ||= column.titleize
    css_class = column == sort_column ? "current #{sort_direction}" : nil
    direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
    link_to title, params.merge(:sort => column, :direction => direction, :page => nil), {:class => css_class}
  end
    
  
end
