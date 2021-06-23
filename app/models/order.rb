class Order < ApplicationRecord
  belongs_to :car
  has_many :events

  def get_daily_orders
    self.where("created_at = ?", Time.current.all_day)
  end
end
