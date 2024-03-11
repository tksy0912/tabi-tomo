class Public::PostsController < ApplicationController
  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    @post.save
    redirect_to public_posts_path
  end


  private

  def post_params
    params.require(:post).permit(:title, :caption, :user_id, :trip_id)
  end
end
