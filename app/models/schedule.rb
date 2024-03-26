class Schedule < ApplicationRecord
  belongs_to :trip

  validates :date, presence: true
  validates :destination, presence: true
  validates :transportation, presence: true

end
