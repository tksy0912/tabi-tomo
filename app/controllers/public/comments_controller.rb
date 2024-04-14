class Public::CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    comment = @post.comments.new(comment_params)
    comment.user = current_user
    comment.save
  end

  def destroy
    comment = Comment.find(params[:id])
    @post = comment.post
    comment.destroy
  end


  private

  def comment_params
    params.require(:comment).permit(:comment)
  end
end
