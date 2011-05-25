class User < ActiveRecord::Base
  acts_as_authentic

  belongs_to :household
  belongs_to :role
  
  def is_admin?
    role_symbols.include?(:administrator) || role_symbols.include?(:developer)
  end
  
  def role_symbols
    [role.name.downcase.to_sym]
  end
  
  private

    def assign_default_role
      self.role = Role.find_by_name('member') if role_id.blank?
    end
end
