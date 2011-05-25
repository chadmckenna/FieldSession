class User < ActiveRecord::Base
  acts_as_authentic

  belongs_to :household
  belongs_to :role
end
