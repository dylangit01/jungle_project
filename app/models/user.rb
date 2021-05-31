class User < ActiveRecord::Base
	has_secure_password			# This is the line of code that gives our User model authentication methods via bcrypt.

	# REGEX_PATTERN = /([a-zA-Z0-9+._-]+@[a-zA-Z0-9._-]+\.[a-zA-Z0-9_-]+)/
	REGEX_PATTERN = /\A(([^<>()\[\]\\.,;:\s@\"]+(\.[^<>()\[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))\z/i

  validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: REGEX_PATTERN}
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
