class UserRegionMapping < ActiveRecord::Base
  belongs_to :user
  belongs_to :region
end
