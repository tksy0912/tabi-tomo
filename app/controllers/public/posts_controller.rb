class Public::PostsController < ApplicationController
  def new
    @trip = Trip.find(params[:trip_id])
    @post = Post.new
    @post.trip_id = @trip.id
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
      # 受け取った値を,で区切って配列にする
    tag_list = params[:post][:name].split(',')
    if @post.save
      @post.save_post_tags(tag_list)
      redirect_to public_post_path(@post.id)
    else
      render :new
    end
  end

  def index
    @posts = Post.all
    @tag_list = PostTag.all
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
    @post_tags = @post.post_tags
  end

  def edit
    @user = current_user
    @post = Post.find(params[:id])
    @tag_list = @post.post_tags.pluck(:name).join(',')
  end

  def update
    @user = current_user
    @post = Post.find(params[:id])
    tag_list=params[:post][:name].split(',')
    if @post.update(post_params)
      @post.save_post_tags(tag_list)
      redirect_to public_post_path(@post.id)
    else
      redirect_to request.referer
    end
  end

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
    params.require(:post).permit(:title, :caption, :user_id, :trip_id, :post_image)
  end
end
