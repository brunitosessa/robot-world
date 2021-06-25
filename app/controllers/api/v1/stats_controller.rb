module Api
    module V1
        class StatsController < ApplicationController
            def daily
                sold_cars = Order.where(created_at: Time.current.all_day).includes(:car).map(&:car)
                profit = sold_cars.sum(&:price)
                expenses = sold_cars.sum(&:cost_price)

                render_json = {
                    day: Time.now.strftime("%d/%m/%Y at %k:%M"),
                    total_profit: profit,
                    total_expenses: expenses,
                    net_income: profit - expenses,
                    total_cars_sold: sold_cars.count,
                }

                render json: render_json
            end
        end
    end
end