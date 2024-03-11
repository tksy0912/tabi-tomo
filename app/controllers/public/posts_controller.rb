class Public::PostsController < ApplicationController
  def new
    @trip = Trip.find(params[:trip_id])
    @post = Post.new
    @post.trip_id = @trip.id
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    @post.save
    redirect_to public_post_path(@post.id)
  end

  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
  end


  private

  def post_params
    params.require(:post).permit(:title, :caption, :user_id, :trip_id, :post_image)
  end
end
