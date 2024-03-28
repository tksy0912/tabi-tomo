class Public::SearchesController < ApplicationController
  before_action :authenticate_user!

  def search
    @range = params[:range]
    @word = params[:word]
    @posts = Post.looks(params[:search], params[:word]).order(created_at: :desc).page(params[:page]).per(10)
    @tag_list = PostTag.all
  end
end
