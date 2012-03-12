class Profile < ActiveRecord::Base
  
  belongs_to :user
  has_attached_file :avatar, :styles => { :medium => "300x300>", :small => "100x100>", :thumb => "30x30#" },
  #has_attached_file :avatar, :styles => { :medium => "150x150>", :thumb => "40x40>" },
                    :storage => :s3,
                    # :bucket => 'on-the-crappr',  # Development
                    :bucket => 'hithr.to', #Production
                    :s3_credentials => {
                      :access_key_id => 'AKIAJ4PCXCFUIFXK3LFQ',
                      :secret_access_key => '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'
                    }  
  validates :user_id, :presence => true, :uniqueness => true
  
end
