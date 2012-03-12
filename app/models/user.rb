class User < ActiveRecord::Base
  has_many :authentications,  :dependent => :destroy
  has_many :messages,         :dependent => :destroy
  has_one :profile,           :dependent => :destroy
  has_many :references,       :dependent => :destroy
  has_many :rides,            :dependent => :destroy
  
  after_save :initialize_profile
  
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and 
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable
  validates :firstname, :presence => true
  validates :lastname, :presence => true

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :firstname, :lastname, :password, :password_confirmation, :remember_me
  
  
  def self.find_for_facebook_oauth(access_token, signed_in_resource=nil)
    data = access_token.extra.raw_info
    if user = User.where(:email => data.email).first
      user
    # else # Create a user with a stub password. 
    #       screen_name = data.email.split('@').first
    #       if User.where(:screen_name => screen_name).empty?
    #         User.new(:omniauth_facebook => true, :screen_name => screen_name, :email => data.email, :password => Devise.friendly_token[0,20]) 
    #       else
    #         screen_name = screen_name + '.2'
    #         User.new(:omniauth_facebook => true, :screen_name => screen_name, :email => data.email, :password => Devise.friendly_token[0,20]) 
    #       end
    end
  end
  
  
  def initialize_profile
    profile = Profile.find_or_create_by_user_id(:user_id => id, :cred => 0)
    profile.save
  end
  
  def build_auth(auth)
    authentications.build(:provider => auth['provider'], :uid => auth['uid'], :nickname => auth['info'].nickname)
  end
  
  def username
    "#{firstname.try(:humanize)} #{lastname.to(0).try(:humanize)}"
  end
  
  
  
end
