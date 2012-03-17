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

  def gravatar_for(user, size, options = {})
    if user.profile.avatar_file_name.present?
      image_tag user.profile.avatar.url(size)
    else
      options = { :size => 100 }.merge(options)
      options[:default] = "retro"
      gravatar_image_tag(user.email.downcase, 
            :alt => h(user.firstname),
            :class => 'gravatar',
            :gravatar => options) 
    end
	end
	
	def avatar_medium
	  if @user.profile.avatar_file_name.present? 
	    @user.profile.avatar.url(:medium) 
	  else 
	    @user
	  end 
	end
  
  
end