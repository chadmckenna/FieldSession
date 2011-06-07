class Household < ActiveRecord::Base
  attr_accessible :name, :credits, :photo

  has_many :children
  has_many :users
  has_many :requests
  has_many :hidden_requests
  
  has_many :neighbors, :foreign_key => 'neighbor_id', :class_name => 'Neighbor', :dependent => :destroy
  has_many :households, :through => :neighbors
  
  has_attached_file :photo, 
                    :url => "/assets/:class/:attachment/:id/:basename.:extension",
                    :path => "#{RAILS_ROOT}/public/assets/:class/:attachment/:id/:basename.:extension",
                    :default_url => "/images/default_household.jpg",
                    :storage => :s3,
                    :s3_credentials => "#{RAILS_ROOT}/config/s3.yml"
  
  validates_attachment_presence :photo
  #validates_attachment_content_type :photo, :content_type => ['image/jpeg', 'image/png', 'image/gif']

  #has_many :requestors, :foreign_key => 'household_id', :class_name => 'Neighbor', :dependent => :destroy
  #has_many :households, :through => :requestors
  
  has_many :pending_requests
  #has_many :requests, :through => :pending_requests
  
  has_many :households
  
  before_create :assign_default_credits

  def to_s
    self.name.capitalize
  end
  
  def self.search(search)
    if search
      search.downcase
      find(:all, :conditions => ['name LIKE ?', "%#{search}%"])
    else
      return false
    end
  end

  protected

    def assign_default_credits
      self.credits = 2 if self.credits.nil?
    end

end

