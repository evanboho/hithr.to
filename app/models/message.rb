class Message < ActiveRecord::Base
  
  belongs_to :user
    
  validates :content, :presence => true, :length => { :maximum => 200 }
  validates :sujet, :presence => true, :length => { :maximum => 40 }
  

  def sender
    u = User.where(:id => sender_id)
    if u.present?
      return u.first
    else
      nil
    end
  end
  
  def self.mutual_messages(user, current_user)
    z = self.scoped
    x = z.where(:user_id => user, :sender_id => current_user)
    y = z.where(:sender_id => user, :user_id => current_user)
    # x + y
    z = (x + y).sort { |a,b| b.created_at <=> a.created_at }
  end
  
  def self.my_messages
    self.unread.order('created_at DESC')
  end
  
  def msg_time
        t = created_at.strftime("%b %d, %l:%M")
        t = t + ' am' if created_at.hour < 12
        t = t + ' pm' if created_at.hour > 12
        t
      end
  
  def self.unread
    self.where(:read => false)
  end
  
  def self.sent(user)
    self.where(:sender_id => user.id).order('created_at DESC').limit(5)
  end
  
  def self.archived
    self.where(:read => true)
  end
  
end
