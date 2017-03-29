class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :user_signed_in, only: [:index, :edit, :update, :destroy]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only:  :destroy

  def generate_new_password_email
    user = User.find(params[:id])
    user.send_reset_password_instructions
    flash[:notice] = "Reset password instrutctions have been sent to #{user.email}."
    redirect_to user_path(user)
  end

  private
  # Confirms the correct user.
  def correct_user
    @user = User.find(params[:id])
    redirect_to root_path unless current_user?(@user)
  end

  #Confirms an admin user
  def admin_user
    redirect_to root_path unless current_user.admin?
  end
end
