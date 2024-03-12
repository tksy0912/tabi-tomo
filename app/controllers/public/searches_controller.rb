class Public::SearchesController < ApplicationController
  before_action :authenticate_user!

  def search
    @range = params[:range]
    @word = params[:word]
    @posts = Post.looks(params[:search], params[:word])
  end
end
