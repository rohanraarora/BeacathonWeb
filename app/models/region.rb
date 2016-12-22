class Region < ActiveRecord::Base

  has_many :user_region_mappings
  has_many :users, through: :user_region_mappings

end
