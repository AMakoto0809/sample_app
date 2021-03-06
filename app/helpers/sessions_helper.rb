module SessionsHelper

	#Code10.19 sign_in
	def sign_in(user)
		remember_token = User.new_remember_token
		cookies.permanent[:remember_token] = remember_token
		user.update_attribute(:remember_token,User.encrypt(remember_token))
		self.current_user = user
	end

	#Code10.23
	def signed_in?
		!current_user.nil?
	end

	def current_user=(user)
		@current_user = user
	end

	def current_user
		remember_token = User.encrypt(cookies[:remember_token])
		@current_user ||= User.find_by(remember_token: remember_token)
	end

	#Code11.15
	def current_user?(user)
		user == current_user
	end

	#Code12.24
	def signed_in_user
		unless signed_in?
			store_location
			redirect_to signin_url,notice: "Please signed in."
		end
	end

	#Code10.30
	def sign_out
		self.current_user = nil
		cookies.delete(:remember_token)
	end

	#Code11.17
	def redirect_back_or(default)
		redirect_to(session[:return_to] || default)
		session.delete(:return_to)
	end

	#Code11.17
	def store_location
		session[:return_to] = request.url
	end
end