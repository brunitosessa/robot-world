class PartSerializer < ActiveModel::Serializer
  attributes :id, :defect, :part_type

  belongs_to :part_type

end
