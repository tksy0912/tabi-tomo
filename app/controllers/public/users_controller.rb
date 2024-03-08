class Public::UsersController < ApplicationController
  def show
    @user = current_user
  end

  def edit
  end

  def update
  end


  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end
end
