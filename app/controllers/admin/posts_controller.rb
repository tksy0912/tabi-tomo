class Admin::PostsController < ApplicationController
  # 管理者以外はアクセスできないように
  before_action :authenticate_admin!

  def index
    @posts = Post.all.order(created_at: :desc).page(params[:page]).per(10)
    # .order(created_at: :desc) で新しい順に表示される
  end

  def show
    @post = Post.find(params[:id])
    @user = @post.user
  end


  private

  def post_params
    params.require(:post).permit(:title, :caption, :user_id, :trip_id, :post_image)
  end
end
