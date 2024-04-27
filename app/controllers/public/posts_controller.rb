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
      flash[:notice] = "思い出を投稿しました！"
      @post.save_post_tags(tag_list)
      redirect_to post_path(@post.id)
    else
      flash.now[:alert] = "投稿できませんでした"
      render :new
    end
  end

  def index
    @posts = Post.all.order(created_at: :desc).page(params[:page]).per(10)
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
    redirect_to users_my_page_path(current_user)
  end

  def search_tag
    #検索結果画面でもタグ一覧表示
    @tag_list = PostTag.all
    #検索されたタグを受け取る
    @tag = PostTag.find(params[:post_tag_id])
    #検索されたタグに紐づく投稿を表示
    @posts = @tag.posts.page(params[:page]).per(10)
  end


  private

  def post_params
    params.require(:post).permit(:title, :caption, :user_id, :trip_id, :post_image, :name)
  end
end
