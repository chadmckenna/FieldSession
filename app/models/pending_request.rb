class PendingRequest < ActiveRecord::Base
  belongs_to :household
  belongs_to :request
  
  before_create :assign_default_status
  
  protected
    def assign_default_status
      self.pending = "true"
      self.confirmed = "false"
    end
end
