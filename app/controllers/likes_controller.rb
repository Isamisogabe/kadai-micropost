class LikesController < ApplicationController
  before_action :require_user_logged_in
  def index
    if logged_in?
      @user = current_user
      @microposts = current_user.feed_likes.page(params[:page])
    end
  end
end
