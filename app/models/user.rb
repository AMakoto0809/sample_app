class User < ActiveRecord::Base
	#code 8.29 -SecurePassWord-
	before_save { self.email = email.downcase }

	validates :name, presence: true, 
					 length:{ maximum: 50 }
	
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	
	
	validates :email, presence: true, 
					  format: { with: VALID_EMAIL_REGEX },
					  uniqueness: { case_sensitive: false }

	#Password -list6.27-
	has_secure_password

	#SecurePassword -list6.29-
	validates :password, length: { minimum: 6 }
end