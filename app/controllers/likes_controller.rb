class LikesController < ApplicationController
  def create
    @micropost = Micropost.find(params[:micropost_id])
    @like = @micropost.likes.create(user_id: current_user.id)
    respond_to do |format|
      format.html
      format.js { render action: "toggle" }
    end
  end

  def destroy
    like = Like.find(params[:id])
    @micropost = like.micropost
    like.destroy
    respond_to do |format|
      format.html
      format.js { render action: "toggle" }
    end
  end
end
