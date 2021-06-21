class Part < ApplicationRecord
    belongs_to :part_type
    belongs_to :car, optional: true
    
    validates :defect, inclusion: { in: [true,false] }
end
