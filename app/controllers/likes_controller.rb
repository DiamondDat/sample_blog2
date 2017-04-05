class LikesController < ApplicationController
  def create
    @micropost = Micropost.find(params[:micropost_id])
    @like = @micropost.likes.create(user_id: current_user.id)
    respond_to do |format|
      format.html { redirect_to request.referer }
      format.js
    end
  end

  def destroy
    @like = Like.find(params[:id]).destroy
    respond_to do |format|
      format.html { redirect_to request.referer }
      format.js
    end
  end
end
