class User < ApplicationRecord
  has_secure_password

  validates :password, presence: true
  validates :password_confirmation, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 6 }

  def self.authenticate_with_credentials(email, password)
    user = find_by('LOWER(email) = ?', email.downcase.strip)
    user if user&.authenticate(password)
  end
end
