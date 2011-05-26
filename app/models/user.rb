class User < ActiveRecord::Base
  acts_as_authentic

  belongs_to :household
  belongs_to :role
  
  has_many :requests

  default_scope :include => :role

  before_create :assign_default_role
  
  def is?(role_symbol)
    role_symbols.include? role_symbol
  end
  
  before_validation_on_create :assign_default_role
  
  def is?(role_symbol)
    role_symbols.include? role_symbol
  end
  
  def is_admin?
    role_symbols.include?(:administrator) || role_symbols.include?(:developer)
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

    def validate
      errors.add_to_base "User must have a role." if self.role.nil?
    end

    def assign_default_role
      self.role = Role.find_by_name('member') if role.nil?
    end
end
