class Admin::UsersController < ApplicationController
# 管理者以外はアクセスできないように
  before_action :authenticate_admin!

  def index
    @users = User.all.page(params[:page]).per(5)
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.page(params[:page]).per(10)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to request.referer
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image, :is_active)
  end
end
