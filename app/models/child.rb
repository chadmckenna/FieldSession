class Child < ActiveRecord::Base
                  attr_accessible :first_name, :last_name, :date_of_birth, :dietary_restrictions, :allergies, :medications, :notes

  belongs_to :household

  before_create :assign_default_household

  protected

    def assign_default_household
      self.household = current_user.household if household.nil?
    end

end

