module Api
    module V1
        class EventsController < ApplicationController
            def index
                @events = Event.all
                render json: @events
            end

            def by_car
                @events = Event.where('car_id = ?', params[:id])
                render json: @events
            end

            def by_type
                @events = Event.where('name = ?', params[:name])
                render json: @events
            end

            def by_car_model
                @events = Event.where('model_id = ?', params[:model_id])
                render json: @events
            end
        end
    end
end
