class User < ApplicationRecord
  has_secure_password

  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :password, presence: true, confirmation: true, length: { minimum: 6 }
  validates_presence_of :password_confirmation
  validates :first_name, presence: true
  validates :last_name, presence: true

  def self.authenticate_with_credentials(email, password)
    # Find the user by email (case-insensitive)
    user = User.find_by('lower(email) = ?', email.downcase.strip)
    # If user exists and password is correct using authenticate method
    user.authenticate(password) if user
  end
end




