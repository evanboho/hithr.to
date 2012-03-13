class Profile < ActiveRecord::Base
  
  belongs_to :user
  has_attached_file :avatar, :styles => { :medium => "300x300>", :small => "100x100>", :thumb => "30x30#" },
                    :storage => :s3,
                    :bucket => 'hithr.to',
                    :s3_credentials => {
                      :access_key_id => 'AKIAJ4PCXCFUIFXK3LFQ',
                      :secret_access_key => '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'
                    }  
  validates :user_id, :presence => true, :uniqueness => true
  
  before_save :clean_up_city
  
  def clean_up_city
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
