class Child < ActiveRecord::Base
  attr_accessible :first_name, :last_name, :date_of_birth, :dietary_restrictions, :allergies, :medications, :notes, :household_id

  has_and_belongs_to_many :requests
  belongs_to :household

  validates_presence_of :first_name, :last_name, :date_of_birth

  def full_name
    "#{self.first_name.capitalize} #{self.last_name.capitalize}\n"
  end
  
  def to_s
    self.full_name
  end
  
  protected

    def validate
      errors.add_to_base "Child must be under 18 years of age." if (Date.today.year - date_of_birth.year > 18)
    end

end

