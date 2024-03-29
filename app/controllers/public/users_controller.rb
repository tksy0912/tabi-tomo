class Public::UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @trips = @user.trips
    @posts = @user.posts.order(created_at: :desc).page(params[:page]).per(5)
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      flash[:notice] = "プロフィールを更新しました！"
      redirect_to users_my_page_path(current_user)
    else
      flash.now[:alert] = "プロフィールを更新できませんでした"
      render :edit
    end
  end

  # ユーザーのいいね一覧
  def favorites
    @user = User.find(params[:id])
    favorites = Favorite.where(user_id: @user.id).pluck(:post_id)
    @favorite_posts = Post.find(favorites)
  end


  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end
end
