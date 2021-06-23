class EventSerializer < ActiveModel::Serializer
  attributes :id, :name

  belongs_to :car, optional: true
  belongs_to :order, optional: true
  belongs_to :model, optional: true

end
