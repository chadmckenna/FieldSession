class User < ActiveRecord::Base
  acts_as_authentic
  #attr_accessible :username, :first_name, :last_name, :phone, :email, :work_phone
  validates_format_of :phone,
      :message => "must be 10 digits long and only contain numbers.",
      :with => /^[\(\)0-9\- \+\.]{10,20}$/
  unless :work_phone.nil?
    validates_format_of :work_phone,
      :message => "must be 10 digits long and only contain numbers.",
      :with => /^[\(\)0-9\- \+\.]{10,20}$/,
      :allow_nil => true
  end
  validates_presence_of :role, :message => "cannot be blank."
  validates_confirmation_of :password
  validates_presence_of :username

  belongs_to :household
  belongs_to :role
  has_many :neighbors
  has_many :users, :through => :neighbors
  has_many :requests

  default_scope :include => :role

  before_create :assign_default_role
  before_save :capitalize_names, :remove_non_digits_in_phone

  before_validation_on_create :assign_default_role
  before_validation :clear_empty_attrs

  def send_welcome_email
    UserMailer.deliver_welcome_email(self)
  end

  def send_household_join_confirmation_email
    UserMailer.deliver_household_join_confirmation_email(self)
  end

  def send_household_join_request_email(household)
    @household_users = User.find(:all, :conditions => {:household_id => household.id, :household_confirmed => true})
    for household_user in @household_users
      UserMailer.deliver_household_join_request_email(self, household_user)
    end
  end

  def is?(role_symbol)
    role_symbols.include? role_symbol
  end

  def is_admin?
    role_symbols.include?(:administrator) || role_symbols.include?(:developer)
  end

  def has_household?
    return false if self.household_confirmed.eql? false
    return false if self.household_id.eql?(nil)
    return true
  end

  def is_member?
    role_symbols.include?(:member)
  end

  def is_neighbor?(neighbor_id)
    return true if Neighbor.find(:all, :conditions => {:household_id => self.household_id, :neighbor_id => neighbor_id, :household_confirmed => true, :neighbor_confirmed => true}).count > 0
    return false
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

  def self.search(search)
    if search
      search.downcase
      if /\b[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}\b/i.match(search)
        find(:all, :conditions => ['email LIKE ?', "%#{search}%"])
      else#if /^[01]?[- .]?\(?[2-9]\d{2}\)?[- .]?\d{3}[- .]?\d{4}$/.match(search)
        find(:all, :conditions => ['phone LIKE ?', "%#{search}%"])
      end
    else
      return false
    end
  end
# def self.search(search)
#  if /\b[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}\b/i.match(search)
#      search.downcase
#      find(:all, :conditions => ['email LIKE ?', "%#{search}%"])
#    elsif /^[01]?[- .]?\(?[2-9]\d{2}\)?[- .]?\d{3}[- .]?\d{4}$/.match(search)
#      find(:all, :conditions => ['phone LIKE ?', "%#{search}%"])
#    else
#      return false
#    end
#  end

  protected

    def capitalize_names
      self.first_name = self.first_name.slice(0,1).capitalize + self.first_name.slice(1..-1)
      self.last_name = self.last_name.slice(0,1).capitalize + self.last_name.slice(1..-1)
    end

    def assign_default_role
      self.role = Role.find_by_name('member') if role.nil?
    end

    def remove_non_digits_in_phone
      self.phone = self.phone.gsub(/\D/, "") unless self.phone.blank?
      self.work_phone = self.work_phone.gsub(/\D/, "") unless self.work_phone.blank?
    end

    def clear_empty_attrs
      @attributes.each do |key,value|
        self[key] = nil if value.blank?
      end
    end

end

