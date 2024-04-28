class Trip < ApplicationRecord
  has_many :schedules, dependent: :destroy
  has_many :posts, dependent: :destroy
  accepts_nested_attributes_for :schedules, allow_destroy: true
  belongs_to :user

  validates :title, length: { maximum: 20 }, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true

  # start_timeとend_timeの逆転防止
  validate :start_end_check

  def start_end_check
    errors.add(:end_time,"は出発日以降の日付を選択してください") unless
    self.start_time < self.end_time
  end
end