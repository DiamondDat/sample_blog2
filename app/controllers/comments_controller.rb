class CommentsController < ApplicationController
  before_action :user_signed_in?, only: [:create, :edit, :destroy]
  before_action :correct_user,    only: :destroy
  before_action :find_commentable

  def create
    @comment = params[:micropost_id] ? @commentable.comments.create(comment_params)
                                     : @commentable.replies.create(comment_params)

    if @comment.save
      flash[:success] = "Comment created."
      redirect_to request.referer || root_path
    else
      redirect_to request.referer || root_path
    end
  end

  def destroy

  end

  private
  def comment_params
    params.require(:comment).permit(:content).merge(user_id: current_user.id)
  end

  def correct_user
    @comment = current_user.comments.find_by(id: params[:id])
    redirect_to root_path if @comment.nil?
  end

  def find_commentable
    @commentable = params[:micropost_id] ? Micropost.find(params[:micorpost_id])
                                         : Comment.find(params[:comment_id])
  end
end
