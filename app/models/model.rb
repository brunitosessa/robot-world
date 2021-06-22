class Model < ApplicationRecord
  has_many :cars
  has_many :events

  validates :name, presence: true
end
