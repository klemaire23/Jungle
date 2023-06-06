class User < ApplicationRecord
  has_secure_password
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :first_name, :last_name, :email, presence: true
  validates :password, length: { minimum: 3 }, presence: true

  def self.authenticate_with_credentials(email, password)
    user = User.find_by(email: email.strip.downcase)
    if user && user.authenticate(password)
      user
    else
      nil
    end
  end
end
