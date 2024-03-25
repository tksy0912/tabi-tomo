class Public::PostsController < ApplicationController
  def new
    @trip = Trip.find(params[:trip_id])
    @post = Post.new
    @post.trip_id = @trip.id
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    tag_list = params[:post][:name].split(',')
    if @post.save
      @post.save_post_tags(tag_list)
      redirect_to public_post_path(@post.id)
    else
      render :new
    end
  end

  def index
    @posts = Post.all.page(params[:page]).per(10)
    @tag_list = PostTag.all
  end

  def show
    @post = Post.find(params[:id])
    @trip_id = @post.trip_id
    @comment = Comment.new
    @post_tags = @post.post_tags
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to users_my_page_path
  end

  # def edit
  #   @user = current_user
  #   @post = Post.find(params[:id])
  #   @trip_id = @post.trip_id
  #   @tag_list = @post.post_tags.pluck(:name).join(',')
  # end

  # def update
  #   @post = Post.find(params[:id])
  #   tag_list = params[:post][:name].split(',')
  #   @trip_id = params[:post][:trip_id]
  #   if @post.update(post_params.merge(trip_id: @trip_id))
  #     @post.save_post_tags(tag_list)
  #     redirect_to public_post_path(@post.id)
  #   else
  #     flash.now[:alert] = "投稿を保存できませんでした。入力内容を確認してください。"
  #     render :edit
  #   end
  # end

  def search_tag
    #検索結果画面でもタグ一覧表示
    @tag_list = PostTag.all
    #検索されたタグを受け取る
    @tag = PostTag.find(params[:post_tag_id])
    #検索されたタグに紐づく投稿を表示
    @posts = @tag.posts
  end


  private

  def post_params
    params.require(:post).permit(:title, :caption, :user_id, :trip_id, :post_image, :name)
  end
end
