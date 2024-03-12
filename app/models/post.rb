class Post < ApplicationRecord
  belongs_to :user
  belongs_to :trip
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

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
end
