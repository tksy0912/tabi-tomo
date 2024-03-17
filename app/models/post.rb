class Post < ApplicationRecord
  belongs_to :user
  belongs_to :trip
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :post_trip_tags, dependent: :destroy
  has_many :post_tags, through: :post_trip_tags

  has_one_attached :post_image

  def get_post_image
    (post_image.attached?) ? post_image : 'default-image.jpg'
  end

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

  def self.liked_posts(user, page, per_page) # 1. モデル内での操作を開始
    includes(:favorites) # 2. favorites テーブルを結合
      .where(favorites: { user_id: user.id }) # 3. ユーザーがいいねしたレコードを絞り込み
      .order(created_at: :desc) # 4. 投稿を作成日時の降順でソート
      .page(page) # 5. ページネーションのため、指定ページに表示するデータを選択
      .per(per_page) # 6. ページごとのデータ数を指定
  end

  def self.looks(search, word)
    if search == "perfect_match"
      @post = Post.where("title LIKE?","#{word}")
    elsif search == "partial_match"
      @post = Post.where("title LIKE?","%#{word}%")
    else
      @post = Post.all
    end
  end

  def save_post_tags(tags)
    # タグが存在していれば、タグの名前を配列として全て取得
    current_tags = self.post_tags.nil? ? [] : self.post_tags.pluck(:name)
    # 現在取得したタグから送られてきたタグを除いてoldtagとする
    old_tags = current_tags - tags
    # 送信されてきたタグから現在存在するタグを除いたタグをnewとする
    new_tags = tags - current_tags

    # 古いタグを消す
    old_tags.each do |old_name|
      self.post_tags.delete PostTag.find_by(name:old_name)
    end

    # 新しいタグを保存
    new_tags.each do |new_name|
      post_tag = PostTag.find_or_create_by(name:new_name)
      self.post_tags << post_tag
    end
  end
end
