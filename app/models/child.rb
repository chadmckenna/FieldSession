class Child < ActiveRecord::Base
  attr_accessible :first_name, :last_name, :date_of_birth, :dietary_restrictions, :allergies, :medications, :notes

  belongs_to :household

  validates_presence_of :first_name, :last_name, :date_of_birth, :dietary_restrictions, :allergies, :medications, :notes

  before_create :assign_default_household

  protected

    def assign_default_household
      self.household = @current_household if self.household.nil?
    end

    def validate
      errors.add_to_base "Child must be under 18 years of age." if (Date.today.year - date_of_birth.year > 18)
    end

end

