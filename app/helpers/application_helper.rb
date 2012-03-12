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
  
  def line_breaks(msg)
    msg.split("\n")
  end
  
  def state_select(form, attribute)
    state_list = ['AL',
  					'AK',
  					'AZ',
  					'AR',
  					'CA',
  					'CO',
  					'CT',
  					'DE',
  					'FL',
  					'GA',
  					'HI',
  					'ID',
  					'IL',
  					'IN',
  					'IA',
  					'KS',
  					'KY',
  					'LA',
  					'ME',
  					'MD',
  					'MA',
  					'MI',
  					'MN',
  					'MS',
  					'MO',
  					'MT',
  					'NE',
  					'NV',
  					'NH',
  					'NJ',
  					'NM',
  					'NY',
  					'NC',
  					'ND',
  					'OH',
  					'OK',
  					'OR',
  					'PA',
  					'RI',
  					'SC',
  					'SD',
  					'TN',
  					'TX',
  					'UT',
  					'VT',
  					'VA',
  					'WA',
  					'WV',
  					'WI',
  					'WY']

  	form.select(attribute, state_list, {}, {class: "chzn-select", style:"width:60px"})
  end
  
end
