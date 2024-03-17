class PostTag < ApplicationRecord
  has_many :post_trip_tags, dependent: :destroy
  has_many :posts, through: :post_trip_tags
  #2つのモデル間の関連がpost_trip_tagsモデルを通じて行われる。

  validates :name, presence:true, length:{maximum:50}
end
