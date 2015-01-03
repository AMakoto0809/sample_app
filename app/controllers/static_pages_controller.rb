class StaticPagesController < ApplicationController
  def home
    #Code12.38
    if signed_in?
      #Code12.31
  	  @micropost = current_user.microposts.build
      @feed_items = current_user.feed.paginate(page: params[:page])
    end
  end

  def help
  end

  def about
  end

  def contact
  	
  end
end
