class LikeRelationshipsController < ApplicationController
  def create
    micropost = Micropost.find(params[:id])
    current_user.like(micropost)
    flash[:success] = 'お気に入りに登録しました'
    redirect_to current_user
  end

  def destroy
    micropost = Micropost.find(params[:id])
    current_user.unlike(micropost)
    flash[:success] = 'お気に入りを取り消しました'
    redirect_to current_user
  end
end
