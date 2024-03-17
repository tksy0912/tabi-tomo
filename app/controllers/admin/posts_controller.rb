class Admin::PostsController < ApplicationController
# 管理者以外はアクセスできないように
  before_action :authenticate_admin!

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