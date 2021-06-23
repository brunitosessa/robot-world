class Car < ApplicationRecord
    belongs_to :computer, optional: true
    belongs_to :model
    has_one :order
    has_many :parts
    has_many :events

    validates_presence_of :year, :model
    validates_uniqueness_of :computer_id, allow_nil: true
    

    accepts_nested_attributes_for :computer

    ###################
    ## CLASS METHODS
    ###################

    # Class method to check factory stock by model
    def self.check_factory_stock(model)
        Car.where('location = ?', 'warehouse').includes(:model).where(models: model).count
    end

    # Class method to check store stock by model
    def self.check_store_stock(model)
        Car.where('location = ?', 'store').includes(:model).where(models: model).count
    end

    # Class method that return defective cars
    def self.defective_cars
        Car.where('location = ?' ,'warehouse').joins(:parts).where('parts.defect = ?', true)
    end

    # Class method to get a car by model to sell, if none available, return 0
    def self.get_car_to_sell(model)
        if self.check_store_stock(model) > 0
            self.where(location: "store").includes(:model).where(models: model).first
        else
            false
        end
    end

    ###################
    ## INSTANCE METHODS
    ###################

    # Instance method to sell a car
    def sell
        if self.status == "complete" && self.location == 'store'
            self.status = "sold"
            self.location = "sold"
        end
    end

    # Instance method to return a car
    def return
        if self.status == 'sold' && self.location == 'sold'
            self.status = 'complete'
            self.location = 'store'
        end
    end

    def is_complete?
        if self.status == 'complete'
            return true
        else
            return self.status
        end
    end
end
