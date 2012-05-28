class Profile < ActiveRecord::Base
  
  belongs_to :user
  has_attached_file :avatar, :styles => { :medium => "300x300>", :small => "100x100>", :thumb => "20x20#" },
                    :storage => :s3,
                    :bucket => 'hithr.to',
                    :s3_credentials => {
                      :access_key_id => ENV['S3_KEY'],
                      :secret_access_key => ENV['S3_SECRET']
                    }  
  validates :user_id, :presence => true, :uniqueness => true
  
  before_save :clean_up_city
  
  def clean_up_city
    if self.hometown?
    c_s = self.hometown.split(',')
    c = c_s.first.try(:titleize).try(:strip)
    if c_s.count > 1
      s = c_s.last.try(:strip).try(:upcase)
      c_s = c + ', ' + s
    else
      c_s = c
    end
    self.hometown = c_s
    end
  end
  
  #   def gravatar_for(user, size, options = {})
  #     if user.profile.avatar_file_name.present?
  #       image_tag user.profile.avatar.url(size)
  #     else
  #       options = { :size => 100 }.merge(options)
  #       options[:default] = "retro"
  #       gravatar_image_tag(user.email.downcase, 
  #             :alt => h(user.firstname),
  #             :class => 'gravatar',
  #             :gravatar => options) 
  #     end
  # end
  
end
