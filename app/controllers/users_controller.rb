class UsersController < ApplicationController

  #Code11.12
  #Code11.34
  #Code11.44
  before_action :signed_in_user,only:[:index,:edit,:update,:destroy]
  before_action :correct_user,  only:[:edit,:update]
  before_action :admin_user,    only: :destroy

  def new
  	@user = User.new
  end

  #Code11.21
  def index
    #Code11.34
    @users = User.paginate(page: params[:page])
  end

  def show
  	@user = User.find(params[:id])
    #Code12.19
    @microposts = @user.microposts.paginate(page: params[:page])
  end

  def create
  	@user = User.new(user_params)
  	if @user.save
  		#user.save success
      
      #flash message
      flash[:success] = "Welcome to the sample app"

      redirect_to @user
  	else
  		render 'new'
  	end
  end

  #Code11.2
  def edit
    #Code11.14 before_actionで定義しているためコメント化
    #@user = User.find(params[:id])
  end

  #Code11.8
  def update
    #Code11.14 before_actionで定義しているためコメント化
    #@user = User.find(params[:id])
    if @user.update_attributes(user_params)
      #更新に成功した場合を扱う。
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User destroyed."
    redirect_to users_url
  end

#Code11.12
private

  def user_params
    params.require(:user).permit(:name,:email,:password,:password_confirmation)
  end

  #Before actions

  #Code12.24 app/helpers/sessions_helper.rb へ追加したため下記記述をコメント
  #def signed_in_user
  #  unless signed_in?
  #    #Code11.18
  #    store_location
  #    redirect_to signin_url,notice: "Please sign in."
  #  end
  #end

  #Code11.14
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_path) unless correct_user?(@user)
  end

  def admin_user
    redirect_to(root_path) unless current_user.admin
  end

end