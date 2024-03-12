class Post < ApplicationRecord
  belongs_to :user
  belongs_to :trip
  has_many :comments, dependent: :destroy

  has_one_attached :post_image

  def get_post_image
    (post_image.attached?) ? post_image : 'default-image.jpg'
  end
end
