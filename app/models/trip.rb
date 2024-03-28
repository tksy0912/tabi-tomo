class Trip < ApplicationRecord
  has_many :schedules, dependent: :destroy
  has_many :posts, dependent: :destroy
  accepts_nested_attributes_for :schedules, allow_destroy: true
  belongs_to :user

  validates :title, length: { maximum: 20 }, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true
end
