class User < ActiveRecord::Base

  has_many :user_region_mappings
  has_many :regions, through: :user_region_mappings

  def generate_token
    self.token = loop do
      random_token = SecureRandom.uuid.gsub(/\-/,'')
      break random_token unless self.class.exists?(token: random_token)
    end
    self.token_expiry_date = Date.today + 60
  end
end
