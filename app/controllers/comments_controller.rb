class CommentsController < ApplicationController
  before_action :user_signed_in?, only: [:create, :edit, :destroy]
  before_action :correct_user,    only: :destroy
  before_action :find_commentable

  def create
    @comment = params[:micropost_id] ? @commentable.comments.create(comment_params)
                                     : @commentable.replies.create(comment_params)

    # Add user directly to comment
    @comment.user = current_user

    # if @comment.save
    #   flash[:success] = "Comment created."
    #   redirect_to request.referer || root_path
    # else
    #   redirect_to request.referer || root_path
    # end

    respond_to do |format|
      if @comment.save
        format.html { redirect_to request.referer || root_path, notice: "Comment created." }
        format.js
      else
        format.html { redirect_to request.referer || root_path }
      end
    end
  end


  def destroy
    @comment = Comment.find(params[:id]).destroy
    flash[:success] = "Comment removed."
    redirect_to request.referer || root_path
  end

  private
  def comment_params
    params.require(:comment).permit(:content)
  end

  def correct_user
    @comment = current_user.comments.find_by(id: params[:id])
    redirect_to root_path if @comment.nil?
  end

  def find_commentable
    @commentable = params[:micropost_id] ? Micropost.find(params[:micropost_id])
                                         : Comment.find(params[:comment_id])
  end
end
