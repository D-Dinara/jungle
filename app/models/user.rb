class User < ApplicationRecord
  has_secure_password

  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :password, presence: true, confirmation: true
  validates_presence_of :password_confirmation
  validates :first_name, presence: true
  validates :last_name, presence: true
end


