class CarSerializer < ActiveModel::Serializer
  attributes :id, :year, :defective_parts, :status, :location

  belongs_to :model
  has_many :parts

  def defective_parts
    object.computer.has_defects?
  end

end
