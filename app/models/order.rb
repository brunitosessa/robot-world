class Order < ApplicationRecord
  belongs_to :car, optional: true
  has_many :events
end
