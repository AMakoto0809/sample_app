class User < ActiveRecord::Base
	#Code12.8
	#Code12.13(dependent: :destroy)
	has_many :microposts,dependent: :destroy
	
	#code 8.29 -SecurePassWord-
	before_save { self.email = email.downcase }

	#Code 10.18 remember_token
	before_create :create_remember_token

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

	def feed
		Micropost.where("user_id = ?",id)
	end

	def User.new_remember_token
		SecureRandom.urlsafe_base64
	end

	def User.encrypt(token)
		Digest::SHA1.hexdigest(token.to_s)
	end

	private

		def create_remember_token
			self.remember_token = User.encrypt(User.new_remember_token)
		end
end