class HiddenRequest < ActiveRecord::Base
  belongs_to :request
  belongs_to :household
end
