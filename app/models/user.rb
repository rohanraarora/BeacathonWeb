class User < ActiveRecord::Base

  def generate_token
    self.token = loop do
      random_token = SecureRandom.uuid.gsub(/\-/,'')
      break random_token unless self.class.exists?(token: random_token)
    end
    self.token_expiry_date = Date.today + 60
  end
end
