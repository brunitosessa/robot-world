class Car < ApplicationRecord
    belongs_to :model
    has_many :parts

    validates :year, presence: :true


    ###################
    ## CLASS METHODS
    ###################

    # Class method to check factory stock by model
    def self.check_factory_stock(model)
        Car.where('location = ?', 'warehouse').includes(:model).where(models: {name: model}).count
    end

    # Class method to check store stock by model
    def self.check_store_stock(model)
        Car.where('location = ?', 'store').includes(:model).where(models: {name: model}).count
    end

    # Class method to get a car by model to sell, if none available, return 0
    def self.get_car_to_sell(model)
        if self.check_store_stock(model) > 0
            self.where(location: "store").includes(:model).where(models: {name: model}).first
        else
            false
        end
    end

    ###################
    ## INSTANCE METHODS
    ###################

    # Instance method to returns CarComputer object from car
    def computer
        self.parts.where('type = ?', 'CarComputer').first
    end

    # Instance method to sell a car
    def sell
        if self.status = "complete" && self.location = 'store'
            self.status = "sold"
            self.location = "sold"
        end
    end

    # Instance method to returns True if car is complete or the line in production
    def is_complete?
        if car.status == "complete"
            return true
        else
            return car.status
        end
    end

    # Instance method that returns parts name with defects, False if none
    def has_defects?
        defects = []
        self.parts.each do |part|
            if (part.defect == true)
                defects.push(part.part_type.name)
            end
        end
        defects.empty? ? false : defects 
    end
end
