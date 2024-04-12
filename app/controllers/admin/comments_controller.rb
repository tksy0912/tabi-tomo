class Admin::CommentsController < ApplicationController
  # 管理者以外はアクセスできないように
  before_action :authenticate_admin!

  def destroy
    Comment.find(params[:id]).destroy
    redirect_to request.referer
  end


  private

  def comment_params
    params.require(:comment).permit(:comment)
  end
end
