class User < ActiveRecord::Base
	has_secure_password			# This is the line of code that gives our User model authentication methods via bcrypt.
end
