class Public::UsersController < ApplicationController
  def show
    @user = current_user
    @trips = Trip.all
    @posts = @user.posts
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    @user.update(user_params)
    redirect_to users_my_page_path(@user)
  end


  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end
end
