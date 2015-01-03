#Code12.25
class MicropostsController < ApplicationController
	#Code12.46
	before_action :signed_in_user,	only: [:create,:destroy]
	before_action :correct_user,	only: :destroy

	def create
		@micropost = current_user.microposts.build(micropost_params)
		if @micropost.save
			flash[:success] = "Micropost created!"
			redirect_to root_url
		else
			@feed_items = []	#Code12.42
			render 'static_pages/home'
		end
	end

	#Code12.46
	def destroy
		@micropost.destroy
		redirect_to root_url
	end

	private

		def micropost_params
			params.require(:micropost).permit(:content)
		end

		#Code12.46
		def correct_user
			@micropost = current_user.microposts.find_by(id: params[:id])
			redirect_to root_url if @micropost.nil?
		end
end