class Computer < ApplicationRecord
    has_one :car

    # Instance method that returns car parts name with defects, False if none
    def has_defects?
        defects = []
        self.car.parts.each do |part|
            if (part.defect == true)
                defects.push(part.part_type.name)
            end
        end
        defects.empty? ? false : defects 
    end

end