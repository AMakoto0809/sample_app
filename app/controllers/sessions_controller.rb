class SessionsController < ApplicationController

	def new
	end

	def create
		user = User.find_by(email: params[:session][:email].downcase)
		if user && user.authenticate(params[:session][:password])
			#ユーザーをサインインさせ、ユーザーページ(show)にリダイレクトさせる。
			sign_in user
			redirect_to user
		else
			flash.now[:error] = 'Invalid email/password combination' #誤りあり
			render 'new'
		end
	end

	#Code10.29
	def destroy
		sign_out
		redirect_to root_url
	end
end