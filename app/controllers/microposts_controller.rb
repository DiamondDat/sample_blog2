class MicropostsController < ApplicationController
  before_action :user_signed_in?, only: [:create, :destroy]
  before_action :correct_user,    only: :destroy

  def create
    @micropost = current_user.microposts.create(micropost_params)

    if @micropost.save
      flash[:success] = "Your micropost is successfully created."
      redirect_to root_path
    else
      @feed_items = []
      redirect_to request.referer || user_path
    end
  end

  def destroy
    Micropost.find(params[:id]).destroy
    flash[:success] = "Micropost deleted."
    redirect_to request.referer || root_path
  end

  private

  # Strong parameters
  def micropost_params
    params.require(:micropost).permit(:content, :picture)
  end

  # Confirms correct user
  def correct_user
    @micropost = current_user.microposts.find_by(params[:id])
    redirect_to root_path if @micropost.nil?
  end
end
