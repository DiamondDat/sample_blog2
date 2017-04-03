class LikesController < ApplicationController
  def create
    @micropost = Micropost.find(params[:id])
    @like = @micropost.likes.create(user_id: current_user.id)
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end

  def destroy
    like = Like.find(params[:id]).destroy
    @micropost = like.micropost
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end
end
