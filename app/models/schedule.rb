class Schedule < ApplicationRecord
  belongs_to :trip

  validates :date, presence: true
  validates :destination, presence: true
  validates :transportation, presence: true

  validates :accommodation_name, presence: true, if: :is_accommodation?

  def is_accommodation?
    is_accommodation.present? && is_accommodation
  end
end
