module MessageMailerHelper


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
		
end
