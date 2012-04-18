class CommentsController < ApplicationController

  def create
    @comment = Comment.new(params[:comment])
    # @comment.user = current_user.id
    if @comment.save
      flash[:notice] = "comment posted!"
      redirect_to posts_path
    else
      flash[:warning] = "oops!"
      redirect_to @comment.post
    end
  end
  
  def destroy
    @comment = Comment.find(params[:id])
    @post = @comment.post
    @comment.destroy
    redirect_to @post
  end

end