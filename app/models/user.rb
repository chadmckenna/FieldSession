class User < ActiveRecord::Base
  acts_as_authentic
  #attr_accessible :username, :first_name, :last_name, :phone, :email
  validates_format_of :phone,
      :message => "must be a valid telephone number.",
      :with => /^[\(\)0-9\- \+\.]{10,20}$/
  validates_presence_of :role, :message => "cannot be blank."
  validates_confirmation_of :password

  belongs_to :household
  belongs_to :role
  has_many :neighbors
  has_many :users, :through => :neighbors
  has_many :requests

  default_scope :include => :role

  before_create :assign_default_role, :remove_non_digits_in_phone
  
  before_validation_on_create :assign_default_role
  
  def send_welcome_email
    #UserMailer.welcome_email(self)
  end
  
  def is?(role_symbol)
    role_symbols.include? role_symbol
  end
  
  def is_admin?
    role_symbols.include?(:administrator) || role_symbols.include?(:developer)
  end
  
  def has_household?
    return false if self.household_id.eql? nil
    return true
  end
  
  def is_member?
    role_symbols.include?(:member)
  end
  
  def role_symbols
    [role.name.downcase.to_sym]
  end
  
  def full_name
    "#{self.first_name} #{self.last_name}"
  end
  
  def to_s
    self.full_name
  end
    
  protected

    def assign_default_role
      self.role = Role.find_by_name('member') if role.nil?
    end
    
    def remove_non_digits_in_phone
      self.phone = self.phone.gsub(/\D/, "")
    end
    
end
