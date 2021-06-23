module Api
    module V1
        class CarsController < ApplicationController
            before_action :set_car, only: [:show]

            # Method for list of cars
            def index
                @cars = Car.all.order(id: :asc)

                render json: @cars
            end

            # Method for list one car (params[:id])
            def show
                render json: @car
            end

            # Method for list defectives cars
            def defectives
                @defectives = Car.defective_cars

                render json: @defectives
            end

            private

            def set_car
              @car = Car.find(params[:id])
            end
        end
    end
end
