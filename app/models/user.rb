class User < ActiveRecord::Base
	has_secure_password			# This is the line of code that gives our User model authentication methods via bcrypt.

  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :name, presence: true
  validates :password, presence: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true

  def self.authenticate_with_credentials(email, password)
    user = User.find_by_email(email.strip.downcase)
    # If user exists and password is correct
    if user && user.authenticate(password)
      user
    else
      nil
    end
  end


end
