class Household < ActiveRecord::Base
  attr_accessible :name, :credits, :photo, :home_phone

  has_many :children
  has_many :users
  has_many :requests
  has_many :hidden_requests
  has_one  :address, :dependent => :destroy
  #has_many :requestors, :foreign_key => 'household_id', :class_name => 'Neighbor', :dependent => :destroy
  #has_many :households, :through => :requestors
  has_many :pending_requests
  #has_many :requests, :through => :pending_requests
  has_many :households
  has_many :neighbors, :foreign_key => 'neighbor_id', :class_name => 'Neighbor', :dependent => :destroy
  has_many :households, :through => :neighbors
  has_many :emergency_contacts
  
  has_attached_file :photo, 
                    :styles => {
                      :thumb => "200x200>",
                      :medium => "600x600>",
                      :tiny => "25x25>"
                    },
                    :url => "/assets/:class/:attachment/:id/:style.:extension",
                    :path => "#{RAILS_ROOT}/public/assets/:class/:attachment/:id/:style.:extension",
                    :default_url => "/images/default_household_:style.jpg",
                    :storage => :s3,
                    :s3_credentials => "#{RAILS_ROOT}/config/s3.yml"
                    
  validates_format_of :home_phone,
      :message => "must be 10 digits long and only contain numbers.",
      :with => /^[\(\)0-9\- \+\.]{10,20}$/
      
  validates_associated :address
  #validates_attachment_presence :photo
  #validates_attachment_content_type :photo, :content_type => ['image/jpeg', 'image/png', 'image/gif']
  
  before_create :assign_default_credits
  before_save :capitalize_name

  def to_s
    self.name.capitalize
  end
  
  def self.search(search)
    if search
      search.upcase
      find(:all, :conditions => ['name LIKE UPPER(?)', "%#{search}%"])
    else
      return false
    end
  end

  protected
  
    def capitalize_name
      self.name = self.name.slice(0,1).capitalize + self.name.slice(1..-1)
    end

    def assign_default_credits
      self.credits = 2 if self.credits.nil?
    end

end

